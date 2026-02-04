package com.sulake.habbo.window.handlers
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class HabbletLinkHandler implements ILinkEventTracker, class_13
   {
      
      private var _windowManager:HabboWindowManagerComponent;
      
      public function HabbletLinkHandler(param1:HabboWindowManagerComponent)
      {
         super();
         _windowManager = param1;
      }
      
      public function get linkPattern() : String
      {
         return "habblet/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc3_:String = null;
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         var _loc4_:* = _loc2_[1];
         if("open" === _loc4_)
         {
            if(_loc2_.length > 2)
            {
               _loc3_ = _loc2_[2];
               if(_loc3_ == "credits")
               {
                  HabboWebTools.openWebPageAndMinimizeClient(_windowManager.getProperty("web.shop.relativeUrl"));
               }
               else
               {
                  HabboWebTools.openWebHabblet(_loc3_);
               }
            }
         }
      }
      
      public function dispose() : void
      {
         _windowManager = null;
      }
      
      public function get disposed() : Boolean
      {
         return _windowManager == null;
      }
   }
}

