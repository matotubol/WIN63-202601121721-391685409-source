package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.SelectorDefinition;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.wired_setup.class_2403;
   import com.sulake.habbo.roomevents.wired_setup.class_2510;
   
   public class SelectorTypes implements class_2510
   {
      
      private var var_57:Array = [];
      
      public function SelectorTypes()
      {
         super();
         this.var_57.push(new class_3705());
         this.var_57.push(new class_3892());
         this.var_57.push(new class_4037());
         this.var_57.push(new class_3812());
         this.var_57.push(new class_3855());
         this.var_57.push(new class_3944());
         this.var_57.push(new class_3829());
         this.var_57.push(new FurniInArea());
         this.var_57.push(new class_3973());
         this.var_57.push(new UsersPerformingAction());
         this.var_57.push(new class_3806());
         this.var_57.push(new UsersByName());
         this.var_57.push(new class_3793());
         this.var_57.push(new UsersInArea());
         this.var_57.push(new class_3738());
         this.var_57.push(new UsersInGroup());
         this.var_57.push(new class_3797());
         this.var_57.push(new class_3993());
         this.var_57.push(new class_4025());
         this.var_57.push(new class_3939());
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
         return "selector";
      }
      
      public function acceptTriggerable(param1:class_2397) : Boolean
      {
         return param1 as SelectorDefinition != null;
      }
   }
}

