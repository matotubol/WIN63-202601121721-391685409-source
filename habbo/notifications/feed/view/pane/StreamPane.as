package com.sulake.habbo.notifications.feed.view.pane
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.notifications.feed.NotificationView;
   import com.sulake.habbo.notifications.feed.view.content.class_3007;
   
   public class StreamPane extends AbstractPane
   {
      
      private var var_121:IItemListWindow;
      
      public function StreamPane(param1:String, param2:NotificationView, param3:class_1812)
      {
         super(param1,param2,param3,1);
         var_121 = _window.findChildByName("list") as IItemListWindow;
      }
      
      override public function dispose() : void
      {
         var_121 = null;
         super.dispose();
      }
      
      public function addItem(param1:class_3007) : void
      {
         var_121.addListItem(param1.window);
      }
   }
}

