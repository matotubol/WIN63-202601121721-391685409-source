package com.sulake.habbo.window.utils
{
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import package_26.class_3237;
   
   public class ElementPointerHandler
   {
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_3740:class_3237;
      
      public function ElementPointerHandler(param1:HabboWindowManagerComponent)
      {
         super();
         _windowManager = param1;
         if(_windowManager.communication != null)
         {
            var_3740 = new class_3237(onElementPointerMessage);
            _windowManager.communication.addHabboConnectionMessageEvent(var_3740);
         }
      }
      
      private function onElementPointerMessage(param1:class_3237) : void
      {
         var _loc2_:String = param1.getParser().key;
         if(_loc2_ == null || _loc2_ == "")
         {
            _windowManager.hideHint();
         }
         else
         {
            _windowManager.showHint(_loc2_);
         }
      }
      
      public function dispose() : void
      {
         if(_windowManager.communication != null)
         {
            _windowManager.communication.removeHabboConnectionMessageEvent(var_3740);
         }
         _windowManager = null;
      }
   }
}

