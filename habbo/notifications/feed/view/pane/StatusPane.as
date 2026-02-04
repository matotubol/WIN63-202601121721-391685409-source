package com.sulake.habbo.notifications.feed.view.pane
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.notifications.feed.NotificationView;
   
   public class StatusPane extends AbstractPane
   {
      
      private static const const_973:String = "minimize_toggle";
      
      private static const NOTIFICATIONS:String = "notification_feed_button";
      
      private static const STREAM:String = "stream_feed_button";
      
      public function StatusPane(param1:String, param2:NotificationView, param3:class_1812)
      {
         super(param1,param2,param3,0);
         _window.findChildByName("minimize_toggle").addEventListener("WME_CLICK",onMinimizeToggle);
         _window.findChildByName("notification_feed_button").addEventListener("WME_CLICK",onSwitchToNotifications);
         _window.findChildByName("stream_feed_button").addEventListener("WME_CLICK",onSwitchToStream);
      }
      
      override public function dispose() : void
      {
         if(_window)
         {
            _window.findChildByName("minimize_toggle").removeEventListener("WME_CLICK",onMinimizeToggle);
            _window.findChildByName("notification_feed_button").removeEventListener("WME_CLICK",onMinimizeToggle);
            _window.findChildByName("stream_feed_button")("WME_CLICK",onMinimizeToggle);
         }
      }
      
      private function onMinimizeToggle(param1:WindowMouseEvent) : void
      {
         var_172.toggleMinimized();
      }
      
      private function onSwitchToNotifications(param1:WindowMouseEvent) : void
      {
         var_172.switchToPane("pane_notifications");
      }
      
      private function onSwitchToStream(param1:WindowMouseEvent) : void
      {
         var_172.switchToPane("pane_stream");
      }
   }
}

