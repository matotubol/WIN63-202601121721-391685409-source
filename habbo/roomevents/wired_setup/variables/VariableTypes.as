package com.sulake.habbo.roomevents.wired_setup.variables
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3381;
   import com.sulake.habbo.roomevents.wired_setup.class_2403;
   import com.sulake.habbo.roomevents.wired_setup.class_2510;
   
   public class VariableTypes implements class_2510
   {
      
      private var var_57:Array = [];
      
      public function VariableTypes()
      {
         super();
         var_57.push(new class_3976());
         var_57.push(new class_3695());
         var_57.push(new class_3804());
         var_57.push(new class_3860());
         var_57.push(new ReferenceVariable());
         var_57.push(new class_3677());
         var_57.push(new class_3991());
         var_57.push(new class_3682());
         var_57.push(new class_3847());
      }
      
      public function getElementByCode(param1:int) : class_2403
      {
         for each(var _loc2_ in var_57)
         {
            if(_loc2_.code == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getKey() : String
      {
         return "variable";
      }
      
      public function acceptTriggerable(param1:class_2397) : Boolean
      {
         return param1 as class_3381 != null;
      }
   }
}

