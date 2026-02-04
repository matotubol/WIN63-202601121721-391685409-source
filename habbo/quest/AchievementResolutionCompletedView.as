package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.widgets.class_3087;
   
   public class AchievementResolutionCompletedView implements class_13
   {
      
      private static const const_202:String = "header_button_close";
      
      private static const const_144:String = "cancel_button";
      
      private var var_55:AchievementsResolutionController;
      
      private var _window:class_2250;
      
      private var var_2806:String;
      
      private var var_3283:String;
      
      public function AchievementResolutionCompletedView(param1:AchievementsResolutionController)
      {
         super();
         var_55 = param1;
      }
      
      public function dispose() : void
      {
         var_55 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_55 != null;
      }
      
      public function get visible() : Boolean
      {
         if(!_window)
         {
            return false;
         }
         return _window.visible;
      }
      
      public function show(param1:String, param2:String) : void
      {
         if(_window == null)
         {
            createWindow();
         }
         initializeWindow();
         var_3283 = param1;
         var_2806 = param2;
         setBadge(var_2806);
         _window.visible = true;
      }
      
      private function createWindow() : void
      {
         _window = class_2250(var_55.questEngine.getXmlWindow("AchievementResolutionCompleted"));
         addClickListener("header_button_close");
         addClickListener("cancel_button");
      }
      
      private function addClickListener(param1:String) : void
      {
         var _loc2_:class_1741 = _window.findChildByName(param1);
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onMouseClick);
         }
      }
      
      private function onMouseClick(param1:WindowMouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "header_button_close":
            case "cancel_button":
               close();
         }
      }
      
      private function initializeWindow() : void
      {
         _window.center();
      }
      
      private function setBadge(param1:String) : void
      {
         var _loc3_:class_2010 = _window.findChildByName("achievement_badge") as class_2010;
         var _loc2_:class_3087 = _loc3_.widget as class_3087;
         IStaticBitmapWrapperWindow(class_1812(_loc3_.rootWindow).findChildByName("bitmap")).assetUri = "common_loading_icon";
         _loc2_.badgeId = param1;
         _loc3_.visible = true;
      }
      
      public function close() : void
      {
         if(_window)
         {
            _window.visible = false;
         }
      }
   }
}

