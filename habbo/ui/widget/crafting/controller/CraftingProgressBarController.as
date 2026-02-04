package com.sulake.habbo.ui.widget.crafting.controller
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class CraftingProgressBarController
   {
      
      private var var_16:CraftingWidget;
      
      private var var_2474:Timer;
      
      private var var_2294:Number;
      
      public function CraftingProgressBarController(param1:CraftingWidget)
      {
         super();
         var_16 = param1;
         var_2474 = new Timer(70);
         var_2474.addEventListener("timer",onProgressTimerEvent);
      }
      
      public function dispose() : void
      {
         var_16 = null;
      }
      
      private function setProgress(param1:Number) : void
      {
         var _loc2_:class_1741 = container.findChildByName("btn_cancel");
      }
      
      private function onProgressTimerEvent(param1:TimerEvent) : void
      {
         var _temp_1:* = §§findproperty(var_2294);
         setProgress(var_2294 = var_2294 + 0.02);
         if(var_2294 >= 1)
         {
            hide();
            var_16.infoCtrl.onProgressBarComplete();
         }
      }
      
      public function hide() : void
      {
         if(var_2474)
         {
            var_2474.stop();
         }
         if(container)
         {
            container.visible = false;
            container.procedure = null;
         }
      }
      
      public function show() : void
      {
         var_2474.start();
         var_2294 = 0;
         if(container)
         {
            container.visible = true;
            container.procedure = onTriggered;
         }
      }
      
      private function onTriggered(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_DOWN")
         {
            return;
         }
         var_16.infoCtrl.cancelCrafting();
      }
      
      private function get container() : class_1812
      {
         if(!var_16 || !var_16.window)
         {
            return null;
         }
         return var_16.window.findChildByName("progress_bar") as class_1812;
      }
   }
}

