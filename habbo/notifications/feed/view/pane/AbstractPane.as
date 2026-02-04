package com.sulake.habbo.notifications.feed.view.pane
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.notifications.feed.NotificationView;
   
   public class AbstractPane implements class_3704
   {
      
      public static const PANE_VIEW_LEVEL_BASE:int = 0;
      
      public static const PANE_VIEW_LEVEL_FEED:int = 1;
      
      public static const PANE_VIEW_LEVEL_MODAL:int = 2;
      
      protected var var_1134:Boolean;
      
      protected var var_1213:Boolean;
      
      private var var_4853:int;
      
      protected var _window:class_1812;
      
      protected var var_172:NotificationView;
      
      protected var _name:String;
      
      public function AbstractPane(param1:String, param2:NotificationView, param3:class_1812, param4:int)
      {
         super();
         if(param3 == null)
         {
            throw new Exception("Window was null for feed pane: " + param1);
         }
         _name = param1;
         var_172 = param2;
         var_4853 = param4;
         _window = param3;
      }
      
      public function dispose() : void
      {
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get paneLevel() : int
      {
         return var_4853;
      }
      
      public function set isVisible(param1:Boolean) : void
      {
         var_1213 = param1;
         _window.visible = var_1213;
      }
      
      public function get isVisible() : Boolean
      {
         return var_1213;
      }
   }
}

