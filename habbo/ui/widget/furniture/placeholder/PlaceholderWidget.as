package com.sulake.habbo.ui.widget.furniture.placeholder
{
   import com.sulake.core.assets.class_40;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetShowPlaceholderEvent;
   import com.sulake.habbo.window.class_38;
   import flash.events.IEventDispatcher;
   
   public class PlaceholderWidget extends RoomWidgetBase
   {
      
      private var var_18:PlaceholderView;
      
      public function PlaceholderWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40 = null, param4:class_27 = null)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         if(var_18 != null)
         {
            var_18.dispose();
            var_18 = null;
         }
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWSPE_SHOW_PLACEHOLDER",onShowEvent);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWSPE_SHOW_PLACEHOLDER",onShowEvent);
      }
      
      private function onShowEvent(param1:RoomWidgetShowPlaceholderEvent) : void
      {
         showInterface();
      }
      
      private function showInterface() : void
      {
         if(var_18 == null)
         {
            var_18 = new PlaceholderView(assets,windowManager);
         }
         var_18.showWindow();
      }
      
      private function hideInterface() : void
      {
         if(var_18 != null)
         {
            var_18.dispose();
            var_18 = null;
         }
      }
   }
}

