package com.sulake.habbo.roomevents.wired_setup
{
   import com.sulake.habbo.roomevents.wired_setup.inputsources.class_2677;
   
   public class WrappedSourceTypeListener implements class_2677
   {
      
      private var var_347:DefaultElement;
      
      private var var_197:int;
      
      public function WrappedSourceTypeListener(param1:DefaultElement, param2:int)
      {
         super();
         var_347 = param1;
         var_197 = param2;
      }
      
      public function set sourceType(param1:int) : void
      {
         var_347.roomEvents.wiredCtrl.setMergedSourceType(var_197,param1);
      }
   }
}

