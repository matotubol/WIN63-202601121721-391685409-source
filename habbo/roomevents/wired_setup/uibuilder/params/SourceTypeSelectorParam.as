package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   import com.sulake.habbo.roomevents.wired_setup.inputsources.class_2677;
   
   public class SourceTypeSelectorParam
   {
      
      private var var_3277:Array;
      
      private var var_4813:int;
      
      private var var_254:class_2677;
      
      public function SourceTypeSelectorParam(param1:Array, param2:class_2677, param3:int = 0)
      {
         super();
         var_3277 = param1;
         var_4813 = param3;
         var_254 = param2;
      }
      
      public function get ids() : Array
      {
         return var_3277;
      }
      
      public function get currentSelection() : int
      {
         return var_4813;
      }
      
      public function get listener() : class_2677
      {
         return var_254;
      }
   }
}

