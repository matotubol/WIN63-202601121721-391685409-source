package com.sulake.habbo.toolbar.memenu
{
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import com.sulake.habbo.utils.HabboFaceFocuser;
   import flash.display.BitmapData;
   import com.sulake.habbo.communication.messages.incoming.avatar.FigureUpdateEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   
   public class MeMenuNewIconLoader implements class_259
   {
      
      private static const MAX_ICON_HEIGHT:int = 50;
      
      private var _toolbar:HabboToolbar;
      
      private var var_3007:String;
      
      private var var_2965:BitmapData;
      
      private var var_1875:UserObjectEvent;
      
      private var var_1871:FigureUpdateEvent;
      
      public function MeMenuNewIconLoader(param1:HabboToolbar)
      {
         super();
         _toolbar = param1;
         var_1875 = new UserObjectEvent(onUserObject);
         var_1871 = new FigureUpdateEvent(onFigureUpdate);
         _toolbar.communicationManager.addHabboConnectionMessageEvent(var_1875);
         _toolbar.communicationManager.addHabboConnectionMessageEvent(var_1871);
         setMeMenuToolbarIcon();
      }
      
      private function setMeMenuToolbarIcon(param1:String = null) : void
      {
         var _loc5_:String = null;
         var _loc3_:String = null;
         var _loc6_:class_1827 = null;
         var _loc4_:BitmapData = null;
         if(_toolbar.avatarRenderManager != null)
         {
            _loc5_ = param1 == null ? _toolbar.sessionDataManager.figure : param1;
            if(_loc5_ != var_3007)
            {
               _loc3_ = _toolbar.sessionDataManager.gender;
               _loc6_ = _toolbar.avatarRenderManager.createAvatarImage(_loc5_,"h",_loc3_,this);
               if(_loc6_ != null && !_loc6_.isPlaceholder())
               {
                  _loc4_ = HabboFaceFocuser.focusUserFace(_loc6_,"full",3,1);
                  _loc6_.dispose();
               }
               var_3007 = _loc5_;
               if(var_2965 != null)
               {
                  var_2965.dispose();
               }
               var_2965 = _loc4_;
            }
            else
            {
               _loc4_ = var_2965;
            }
         }
         if(_toolbar != null)
         {
            if(_loc4_ != null)
            {
               _loc4_ = HabboFaceFocuser.cutCircleFromBitmap(_loc4_,20);
            }
            _toolbar.setIconBitmap("HTIE_ICON_MEMENU",_loc4_);
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var_3007 = "";
         setMeMenuToolbarIcon();
      }
      
      private function onUserObject(param1:UserObjectEvent) : void
      {
         setMeMenuToolbarIcon(param1.getParser().figure);
      }
      
      private function onFigureUpdate(param1:FigureUpdateEvent) : void
      {
         if(disposed)
         {
            return;
         }
         setMeMenuToolbarIcon(param1.figure);
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_1875 != null)
         {
            _toolbar.communicationManager.removeHabboConnectionMessageEvent(var_1875);
            var_1875 = null;
         }
         if(var_1871 != null)
         {
            _toolbar.communicationManager.removeHabboConnectionMessageEvent(var_1871);
            var_1871 = null;
         }
         _toolbar = null;
      }
      
      public function get disposed() : Boolean
      {
         return _toolbar == null;
      }
   }
}

