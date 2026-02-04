package com.sulake.habbo.help.namechange
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.help.INameChangeUI;
   import flash.external.ExternalInterface;
   import package_24.class_1886;
   
   public class NameChangeView implements class_13
   {
      
      private static const NAME_UPDATE_FUNCTION:String = "FlashExternalInterface.updateName";
      
      private static var NAME_SUGGESTION_BG_COLOR:uint = 13232628;
      
      private static var NAME_SUGGESTION_BG_COLOR_OVER:uint = 11129827;
      
      private var var_55:INameChangeUI;
      
      private var _window:class_2250;
      
      private var _checkedName:String;
      
      private var _pendingName:String;
      
      private var var_172:class_1812;
      
      private var var_1486:class_1812;
      
      private var var_1472:class_1812;
      
      private var var_78:class_1812;
      
      private var var_1883:Boolean = false;
      
      private var var_2142:NameSuggestionListRenderer;
      
      private var _disposed:Boolean;
      
      public function NameChangeView(param1:INameChangeUI)
      {
         super();
         var_55 = param1;
      }
      
      public function get id() : String
      {
         return "TUI_NAME_VIEW";
      }
      
      public function set checkedName(param1:String) : void
      {
         _checkedName = param1;
         if(_pendingName == _checkedName)
         {
            showConfirmationView();
            return;
         }
         setNameAvailableView();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            disposeWindow();
            if(var_2142 != null)
            {
               var_2142.dispose();
               var_2142 = null;
            }
            _disposed = true;
         }
      }
      
      private function disposeWindow() : void
      {
         var_172 = null;
         var_1486 = null;
         var_1472 = null;
         var_78 = null;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function showView(param1:class_1812) : void
      {
         var_1883 = false;
         if(var_78)
         {
            var_78.visible = false;
         }
         var_78 = param1;
         var_78.visible = true;
         if(_window)
         {
            _window.content.width = var_78.width;
            _window.content.height = var_78.height;
         }
      }
      
      public function showMainView() : void
      {
         if(!_window)
         {
            _window = var_55.buildXmlWindow("welcome_name_change") as class_2250;
            _window.center();
            _window.procedure = windowEventHandler;
            var_172 = _window.content.getChildAt(0) as class_1812;
         }
         var_55.localization.registerParameter("tutorial.name_change.current","name",var_55.myName);
         _window.caption = var_55.localization.getLocalization("tutorial.name_change.title.main");
         showView(var_172);
      }
      
      private function showSelectionView() : void
      {
         if(!var_1486)
         {
            var_1486 = var_55.buildXmlWindow("welcome_name_selection") as class_1812;
            if(!var_1486)
            {
               return;
            }
            _window.content.addChild(var_1486);
         }
         _window.caption = var_55.localization.getLocalization("tutorial.name_change.title.select");
         var _loc1_:class_1775 = _window.findChildByName("select_name_button") as class_1775;
         if(_loc1_)
         {
            _loc1_.disable();
         }
         setNormalView();
         showView(var_1486);
      }
      
      private function showConfirmationView() : void
      {
         if(!var_1472)
         {
            var_1472 = var_55.buildXmlWindow("welcome_name_confirmation") as class_1812;
            if(!var_1472)
            {
               return;
            }
            _window.content.addChild(var_1472);
         }
         _window.caption = var_55.localization.getLocalization("tutorial.name_change.title.confirm");
         var _loc1_:ITextWindow = var_1472.findChildByName("final_name") as ITextWindow;
         if(_loc1_)
         {
            _loc1_.text = _checkedName;
         }
         showView(var_1472);
         if(ExternalInterface.available)
         {
            ExternalInterface.call("FlashExternalInterface.updateName",_checkedName);
         }
      }
      
      public function get view() : class_1812
      {
         return _window;
      }
      
      public function setNormalView() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:ITextWindow = _window.findChildByName("info_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = var_55.localization.getLocalization("help.tutorial.name.info");
         var _loc1_:class_1812 = _window.findChildByName("suggestions") as class_1812;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.visible = false;
      }
      
      public function setNameAvailableView() : void
      {
         if(_window == null)
         {
            return;
         }
         nameCheckWaitEnd(true);
         var _loc2_:ITextWindow = _window.findChildByName("info_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         var_55.localization.registerParameter("help.tutorial.name.available","name",_checkedName);
         _loc2_.text = var_55.localization.getLocalization("help.tutorial.name.available");
         var _loc3_:ITextFieldWindow = _window.findChildByName("input") as ITextFieldWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.text = _checkedName;
         var _loc1_:class_1812 = _window.findChildByName("suggestions") as class_1812;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.visible = false;
      }
      
      public function setNameNotAvailableView(param1:int, param2:String, param3:Array) : void
      {
         nameCheckWaitEnd(false);
         if(var_78 != var_1486)
         {
            showSelectionView();
         }
         _pendingName = null;
         _checkedName = null;
         if(_window == null)
         {
            return;
         }
         var _loc5_:ITextWindow = _window.findChildByName("info_text") as ITextWindow;
         if(_loc5_ == null)
         {
            return;
         }
         switch(param1)
         {
            case class_1886.var_3330:
               var_55.localization.registerParameter("help.tutorial.name.taken","name",param2);
               _loc5_.text = var_55.localization.getLocalization("help.tutorial.name.taken");
               break;
            case class_1886.var_3157:
               var_55.localization.registerParameter("help.tutorial.name.invalid","name",param2);
               _loc5_.text = var_55.localization.getLocalization("help.tutorial.name.invalid");
               break;
            case class_1886.var_2917:
               _loc5_.text = var_55.localization.getLocalization("help.tutorial.name.long");
               break;
            case class_1886.var_2697:
               _loc5_.text = var_55.localization.getLocalization("help.tutorial.name.short");
               break;
            case class_1886.var_2518:
               _loc5_.text = var_55.localization.getLocalization("help.tutorial.name.change_not_allowed");
               break;
            case class_1886.var_3721:
               _loc5_.text = var_55.localization.getLocalization("help.tutorial.name.merge_hotel_down");
               break;
            case class_1886.var_4470:
         }
         var _loc4_:class_1812 = _window.findChildByName("suggestions") as class_1812;
         if(_loc4_ == null)
         {
            return;
         }
         if(param1 == class_1886.var_3721 || param1 == class_1886.var_2518)
         {
            _loc4_.visible = false;
            return;
         }
         _loc4_.visible = true;
         var_2142 = new NameSuggestionListRenderer(var_55);
         var _loc7_:int = var_2142.render(param3,_loc4_);
         var _loc8_:int = 0;
         while(0 < _loc4_.numChildren)
         {
            var _loc6_:class_1741 = _loc4_.getChildAt(0);
            _loc6_.color = NAME_SUGGESTION_BG_COLOR;
            null.addEventListener("WME_CLICK",nameSelected);
            null.addEventListener("WME_OVER",nameOver);
            null.addEventListener("WME_OUT",nameOut);
            _loc8_++;
         }
      }
      
      private function nameSelected(param1:WindowMouseEvent) : void
      {
         nameCheckWaitEnd(true);
         var _loc4_:ITextWindow = param1.target as ITextWindow;
         if(!_loc4_)
         {
            return;
         }
         var _loc3_:String = _loc4_.text;
         setNormalView();
         var _loc2_:ITextFieldWindow = _window.findChildByName("input") as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = _loc3_;
      }
      
      private function nameOver(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = param1.target as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.color = NAME_SUGGESTION_BG_COLOR_OVER;
         }
      }
      
      private function nameOut(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = param1.target as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.color = NAME_SUGGESTION_BG_COLOR;
         }
      }
      
      public function nameCheckWaitBegin() : void
      {
         var _loc1_:class_1741 = null;
         if(_window && !_window.disposed)
         {
            _loc1_ = _window.findChildByName("select_name_button");
            if(_loc1_)
            {
               _loc1_.disable();
            }
            _loc1_ = _window.findChildByName("check_name_button");
            if(_loc1_)
            {
               _loc1_.disable();
            }
            _loc1_ = _window.findChildByName("input");
            if(_loc1_)
            {
               _loc1_.disable();
            }
            _loc1_ = _window.findChildByName("info_text");
            if(_loc1_)
            {
               _loc1_.caption = var_55.localization.getLocalization("help.tutorial.name.wait_while_checking");
            }
         }
         var_1883 = true;
      }
      
      public function nameCheckWaitEnd(param1:Boolean) : void
      {
         var _loc2_:class_1741 = null;
         if(_window && !_window.disposed)
         {
            if(param1)
            {
               _loc2_ = _window.findChildByName("select_name_button");
               if(_loc2_)
               {
                  _loc2_.enable();
               }
            }
            _loc2_ = _window.findChildByName("check_name_button");
            if(_loc2_)
            {
               _loc2_.enable();
            }
            _loc2_ = _window.findChildByName("input");
            if(_loc2_)
            {
               _loc2_.enable();
            }
         }
         var_1883 = false;
      }
      
      private function windowEventHandler(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:class_1741 = null;
         var _loc4_:ITextFieldWindow = null;
         if(!var_1883)
         {
            if(param1.type == "WE_CHANGE")
            {
               if(param2.name == "input")
               {
                  _loc3_ = _window.findChildByName("select_name_button");
                  _loc4_ = param2 as ITextFieldWindow;
                  if(_loc3_ && _loc4_)
                  {
                     if(_loc4_.text.length > 2)
                     {
                        _loc3_.enable();
                     }
                     else
                     {
                        _loc3_.disable();
                     }
                  }
               }
            }
         }
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "change_name_button":
               showSelectionView();
               break;
            case "keep_name_button":
               _checkedName = var_55.myName;
               showConfirmationView();
               break;
            case "check_name_button":
               var_55.checkName(getName());
               nameCheckWaitBegin();
               break;
            case "select_name_button":
               var _loc5_:String = getName();
               if(_loc5_.length < 1)
               {
                  return;
               }
               if(_checkedName != null)
               {
                  _pendingName = null;
                  var_55.checkName(null);
                  nameCheckWaitBegin();
                  break;
               }
               showConfirmationView();
               break;
            case "cancel_selection_button":
               var_55.hideView();
               break;
            case "confirm_name_button":
               var_55.changeName(_checkedName);
               break;
            case "cancel_confirmation_button":
               var_55.hideView();
               break;
            case "header_button_close":
               var_55.hideView();
         }
      }
      
      private function getName() : String
      {
         var _loc1_:ITextFieldWindow = null;
         if(_window)
         {
            _loc1_ = _window.findChildByName("input") as ITextFieldWindow;
            if(_loc1_)
            {
               return _loc1_.text;
            }
         }
         return null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

