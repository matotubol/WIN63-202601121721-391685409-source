package com.sulake.habbo.help.namechange
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.help.HabboHelp;
   import com.sulake.habbo.help.INameChangeUI;
   import com.sulake.habbo.help.enum.HabboHelpTutorialEvent;
   import com.sulake.habbo.localization.class_27;
   import package_128.class_2461;
   import package_128.class_2470;
   import package_22.class_1789;
   import package_22.class_2414;
   import package_24.class_1886;
   import package_24.class_3130;
   import package_3.class_1804;
   import package_4.class_2005;
   import package_44.class_1913;
   import package_8.class_1953;
   
   public class NameChangeController implements INameChangeUI, class_13
   {
      
      public static const NAME_CHANGE:String = "TUI_NAME_VIEW";
      
      private var _disposed:Boolean;
      
      private var _habboHelp:HabboHelp;
      
      private var var_358:NameChangeView;
      
      private var _ownUserName:String;
      
      private var var_3487:int;
      
      public function NameChangeController(param1:HabboHelp)
      {
         super();
         _habboHelp = param1;
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new class_1804(onUserNameChange));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new class_2005(onUserObject));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new class_1886(onChangeUserNameResult));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new class_3130(onCheckUserNameResult));
      }
      
      public function get help() : HabboHelp
      {
         return _habboHelp;
      }
      
      public function get assets() : class_40
      {
         return _habboHelp.assets;
      }
      
      public function get localization() : class_27
      {
         return _habboHelp.localization;
      }
      
      public function get myName() : String
      {
         return _ownUserName;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            disposeView();
            if(_habboHelp)
            {
               _habboHelp = null;
            }
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function showView() : void
      {
         if(var_358 == null || var_358.disposed)
         {
            var_358 = new NameChangeView(this);
         }
         var_358.showMainView();
         prepareForTutorial();
      }
      
      public function buildXmlWindow(param1:String, param2:uint = 1) : class_1741
      {
         if(_habboHelp.assets == null)
         {
            return null;
         }
         var _loc3_:XmlAsset = XmlAsset(_habboHelp.assets.getAssetByName(param1 + "_xml"));
         if(_loc3_ == null || _habboHelp.windowManager == null)
         {
            return null;
         }
         return _habboHelp.windowManager.buildFromXML(XML(_loc3_.content),param2);
      }
      
      private function disposeWindow(param1:class_1758 = null) : void
      {
      }
      
      public function disposeView() : void
      {
         if(var_358 != null)
         {
            var_358.dispose();
            var_358 = null;
         }
         disposeWindow();
      }
      
      public function hideView() : void
      {
         if(var_358 != null)
         {
            var_358.dispose();
            var_358 = null;
         }
      }
      
      public function setRoomSessionStatus(param1:Boolean) : void
      {
         if(param1 == false)
         {
            disposeView();
         }
      }
      
      public function prepareForTutorial() : void
      {
         if(_habboHelp == null || _habboHelp.events == null)
         {
            return;
         }
         _habboHelp.events.dispatchEvent(new HabboHelpTutorialEvent("HHTPNUFWE_AVATAR_TUTORIAL_START"));
      }
      
      public function windowProcedure(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:* = param1.type;
         if("WME_CLICK" === _loc3_)
         {
            if(param2.name == "header_button_close")
            {
               disposeView();
            }
         }
      }
      
      public function changeName(param1:String) : void
      {
         disposeWindow();
         _habboHelp.sendMessage(new class_2470(param1));
      }
      
      public function checkName(param1:String) : void
      {
         disposeWindow();
         _habboHelp.sendMessage(new class_2461(param1));
      }
      
      public function onUserNameChanged(param1:String) : void
      {
         var name:String = param1;
         if(!_habboHelp || !_habboHelp.localization || !_habboHelp.windowManager)
         {
            return;
         }
         _habboHelp.localization.registerParameter("help.tutorial.name.changed","name",name);
         _habboHelp.windowManager.alert("${generic.notice}","${help.tutorial.name.changed}",0,function(param1:class_1750, param2:class_1758):void
         {
            param1.dispose();
         });
      }
      
      private function onChangeUserNameResult(param1:class_1886) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:class_1789 = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.resultCode == class_1886.var_1851)
         {
            onUserNameChanged(_loc2_.name);
            hideView();
         }
         else if(var_358)
         {
            var_358.setNameNotAvailableView(_loc2_.resultCode,_loc2_.name,_loc2_.nameSuggestions);
         }
      }
      
      private function onCheckUserNameResult(param1:class_3130) : void
      {
         if(!param1 || !var_358)
         {
            return;
         }
         var _loc2_:class_2414 = param1.getParser();
         if(_loc2_.resultCode == class_1886.var_1851)
         {
            var_358.checkedName = _loc2_.name;
         }
         else
         {
            var_358.setNameNotAvailableView(_loc2_.resultCode,_loc2_.name,_loc2_.nameSuggestions);
         }
      }
      
      private function onUserObject(param1:IMessageEvent) : void
      {
         var _loc2_:class_1913 = class_2005(param1).getParser();
         var_3487 = _loc2_.id;
         _ownUserName = _loc2_.name;
      }
      
      private function onUserNameChange(param1:IMessageEvent) : void
      {
         var _loc2_:class_1953 = class_1804(param1).getParser();
         if(var_3487 == _loc2_.webId)
         {
            _ownUserName = _loc2_.newName;
         }
      }
      
      public function get ownUserName() : String
      {
         return _ownUserName;
      }
      
      public function get ownUserId() : int
      {
         return var_3487;
      }
   }
}

