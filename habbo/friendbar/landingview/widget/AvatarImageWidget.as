package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.habbo.avatar.events.AvatarUpdateEvent;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.window.widgets.class_2478;
   import package_39.class_1884;
   import package_4.class_2005;
   
   public class AvatarImageWidget implements ILandingViewWidget
   {
      
      private var _landingView:HabboLandingView;
      
      private var var_2185:class_2010;
      
      private var var_1875:class_2005;
      
      private var var_2100:class_1884;
      
      public function AvatarImageWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
         var_1875 = new class_2005(onUserObject);
         var_2100 = new class_1884(onUserChange);
         _landingView.communicationManager.addHabboConnectionMessageEvent(var_1875);
         _landingView.communicationManager.addHabboConnectionMessageEvent(var_2100);
         _landingView.avatarEditor.events.addEventListener("AVATAR_FIGURE_UPDATED",onAvatarFigureUpdated);
      }
      
      public function get container() : class_1741
      {
         return var_2185;
      }
      
      public function dispose() : void
      {
         if(var_1875 != null)
         {
            _landingView.communicationManager.removeHabboConnectionMessageEvent(var_1875);
            var_1875 = null;
         }
         if(var_2100 != null)
         {
            _landingView.communicationManager.removeHabboConnectionMessageEvent(var_2100);
            var_2100 = null;
         }
         if(_landingView != null)
         {
            _landingView.avatarEditor.events.removeEventListener("AVATAR_FIGURE_UPDATED",onAvatarFigureUpdated);
            _landingView = null;
         }
         var_2185 = null;
      }
      
      public function initialize() : void
      {
         var_2185 = class_2010(_landingView.getXmlWindow("avatar_image"));
      }
      
      public function refresh() : void
      {
         refreshAvatarInfo();
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      private function onUserObject(param1:class_2005) : void
      {
         refreshAvatarInfo(param1.getParser().figure);
      }
      
      private function onUserChange(param1:IMessageEvent) : void
      {
         var _loc2_:class_1884 = param1 as class_1884;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.id == -1)
         {
            refreshAvatarInfo(_loc2_.figure);
         }
      }
      
      private function onAvatarFigureUpdated(param1:AvatarUpdateEvent) : void
      {
         refreshAvatarInfo(param1.figure);
      }
      
      private function refreshAvatarInfo(param1:String = null) : void
      {
         var _loc2_:class_2478 = null;
         if(!param1 && _landingView.sessionDataManager)
         {
            param1 = _landingView.sessionDataManager.figure;
         }
         if(var_2185 != null)
         {
            _loc2_ = var_2185.widget as class_2478;
            if(_loc2_ != null)
            {
               _loc2_.figure = param1;
            }
         }
      }
   }
}

