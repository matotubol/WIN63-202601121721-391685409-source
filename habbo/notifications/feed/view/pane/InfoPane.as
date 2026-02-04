package com.sulake.habbo.notifications.feed.view.pane
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2143;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.notifications.feed.NotificationView;
   
   public class InfoPane extends AbstractPane
   {
      
      public function InfoPane(param1:String, param2:NotificationView, param3:class_1812)
      {
         super(param1,param2,param3,2);
         (_window.findChildByName("info_ok") as class_2143).addEventListener("WME_CLICK",onOkClick);
      }
      
      override public function dispose() : void
      {
         var _loc1_:class_2143 = null;
         super.dispose();
         if(_window)
         {
            _loc1_ = _window.findChildByName("info_ok") as class_2143;
            if(_loc1_)
            {
               _loc1_.removeEventListener("WME_CLICK",onOkClick);
               _loc1_ = null;
            }
         }
      }
      
      private function onOkClick(param1:WindowMouseEvent) : void
      {
         var_172.closePaneLevel(2);
      }
   }
}

