package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2531;
   import com.sulake.habbo.roomevents.wired_setup.class_2403;
   import com.sulake.habbo.roomevents.wired_setup.class_2510;
   
   public class ConditionTypes implements class_2510
   {
      
      private var var_57:Array = [];
      
      public function ConditionTypes()
      {
         super();
         this.var_57.push(new class_3854());
         this.var_57.push(new FurnisHaveAvatars());
         this.var_57.push(new FurnisHaveNoAvatars());
         this.var_57.push(new class_3735());
         this.var_57.push(new class_3925());
         this.var_57.push(new class_3822());
         this.var_57.push(new class_3719());
         this.var_57.push(new class_3820());
         this.var_57.push(new HasStackedFurnis());
         this.var_57.push(new class_4011());
         this.var_57.push(new class_3803());
         this.var_57.push(new class_3887());
         this.var_57.push(new class_3753());
         this.var_57.push(new class_3845());
         this.var_57.push(new DontHaveStackedFurnis());
         this.var_57.push(new class_3979());
         this.var_57.push(new class_3772());
         this.var_57.push(new class_3778());
         this.var_57.push(new class_3763());
         this.var_57.push(new class_4029());
         this.var_57.push(new class_3910());
         this.var_57.push(new ActorIsPerformingAction());
         this.var_57.push(new TeamHasScore());
         this.var_57.push(new class_3717());
         this.var_57.push(new class_3769());
         this.var_57.push(new class_3814());
         this.var_57.push(new class_4016());
         this.var_57.push(new class_3984());
         this.var_57.push(new class_3940());
         this.var_57.push(new class_3830());
         this.var_57.push(new class_3911());
         this.var_57.push(new class_4058());
      }
      
      public function get types() : Array
      {
         return var_57;
      }
      
      public function getByCode(param1:int) : class_3716
      {
         for each(var _loc2_ in var_57)
         {
            if(_loc2_.code == param1)
            {
               return _loc2_;
            }
            if(_loc2_.negativeCode == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getElementByCode(param1:int) : class_2403
      {
         return getByCode(param1);
      }
      
      public function acceptTriggerable(param1:class_2397) : Boolean
      {
         return param1 as class_2531 != null;
      }
      
      public function getKey() : String
      {
         return "condition";
      }
   }
}

