package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3034;
   import com.sulake.habbo.roomevents.wired_setup.class_2403;
   import com.sulake.habbo.roomevents.wired_setup.class_2510;
   
   public class TriggerConfs implements class_2510
   {
      
      private var var_144:Array = [];
      
      public function TriggerConfs()
      {
         super();
         this.var_144.push(new class_3849());
         this.var_144.push(new class_3907());
         this.var_144.push(new class_4018());
         this.var_144.push(new class_3897());
         this.var_144.push(new class_4000());
         this.var_144.push(new class_3697());
         this.var_144.push(new AvatarEntersRoom());
         this.var_144.push(new class_3736());
         this.var_144.push(new class_3771());
         this.var_144.push(new ScoreAchieved());
         this.var_144.push(new class_3755());
         this.var_144.push(new class_3902());
         this.var_144.push(new class_3698());
         this.var_144.push(new class_3994());
         this.var_144.push(new class_3899());
         this.var_144.push(new ClockReachTime());
         this.var_144.push(new PerformAction());
         this.var_144.push(new class_3824());
         this.var_144.push(new class_3956());
         this.var_144.push(new class_4055());
         this.var_144.push(new class_4051());
         this.var_144.push(new class_3714());
         this.var_144.push(new VariableUpdate());
         this.var_144.push(new AvatarLeavesRoom());
         this.var_144.push(new class_3882());
      }
      
      public function get confs() : Array
      {
         return var_144;
      }
      
      public function getByCode(param1:int) : class_3673
      {
         for each(var _loc2_ in var_144)
         {
            if(_loc2_.code == param1)
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
         return param1 as class_3034 != null;
      }
      
      public function getKey() : String
      {
         return "trigger";
      }
   }
}

