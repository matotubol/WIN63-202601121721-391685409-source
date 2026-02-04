package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3042;
   import com.sulake.habbo.roomevents.wired_setup.class_2403;
   import com.sulake.habbo.roomevents.wired_setup.class_2510;
   
   public class ActionTypes implements class_2510
   {
      
      private var var_57:Array = [];
      
      public function ActionTypes()
      {
         super();
         this.var_57.push(new class_3784());
         this.var_57.push(new Reset());
         this.var_57.push(new class_4006());
         this.var_57.push(new class_3826());
         this.var_57.push(new GiveScore());
         this.var_57.push(new class_3972());
         this.var_57.push(new class_4030());
         this.var_57.push(new class_3938());
         this.var_57.push(new class_3685());
         this.var_57.push(new class_3696());
         this.var_57.push(new class_3837());
         this.var_57.push(new class_3908());
         this.var_57.push(new class_3921());
         this.var_57.push(new class_4026());
         this.var_57.push(new class_3709());
         this.var_57.push(new class_4028());
         this.var_57.push(new class_3943());
         this.var_57.push(new KickFromRoom());
         this.var_57.push(new class_3740());
         this.var_57.push(new class_4060());
         this.var_57.push(new class_3945());
         this.var_57.push(new class_3700());
         this.var_57.push(new class_3786());
         this.var_57.push(new class_3680());
         this.var_57.push(new class_3919());
         this.var_57.push(new class_3959());
         this.var_57.push(new class_3788());
         this.var_57.push(new class_3827());
         this.var_57.push(new class_3796());
         this.var_57.push(new class_3905());
         this.var_57.push(new class_3787());
         this.var_57.push(new class_3960());
         this.var_57.push(new class_3935());
         this.var_57.push(new class_3752());
         this.var_57.push(new class_3715());
         this.var_57.push(new class_3791());
         this.var_57.push(new class_3839());
         this.var_57.push(new class_3768());
         this.var_57.push(new class_3909());
         this.var_57.push(new class_3724());
         this.var_57.push(new TeleportToRoom());
         this.var_57.push(new class_3773());
      }
      
      public function get types() : Array
      {
         return var_57;
      }
      
      public function getByCode(param1:int) : ActionType
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
         return param1 as class_3042 != null;
      }
      
      public function getKey() : String
      {
         return "action";
      }
   }
}

