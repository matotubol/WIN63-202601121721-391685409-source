package com.sulake.habbo.communication.messages.parser.talent
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.utils.class_2724;
   
   [SecureSWF(rename="true")]
   public class class_3355
   {
      
      private var var_2493:int;
      
      private var var_61:int;
      
      private var var_1705:Vector.<class_3765> = new Vector.<class_3765>();
      
      private var var_2622:Vector.<class_4056> = new Vector.<class_4056>();
      
      private var var_2332:Vector.<class_3878> = new Vector.<class_3878>();
      
      public function class_3355()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : void
      {
         var_2493 = param1.readInteger();
         var_61 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
      }
      
      public function get level() : int
      {
         return var_2493;
      }
      
      public function set level(param1:int) : void
      {
         var_2493 = param1;
      }
      
      public function get state() : int
      {
         return var_61;
      }
      
      public function set state(param1:int) : void
      {
         var_61 = param1;
      }
      
      public function get tasks() : Vector.<class_3765>
      {
         return var_1705;
      }
      
      public function get rewardPerks() : Vector.<class_4056>
      {
         return var_2622;
      }
      
      public function get rewardProducts() : Vector.<class_3878>
      {
         return var_2332;
      }
      
      public function get rewardCount() : int
      {
         return var_2622.length + var_2332.length;
      }
      
      public function get levelProgress() : Number
      {
         var _loc2_:Number = 1 / var_1705.length;
         for each(var _loc1_ in var_1705)
         {
            if(_loc1_.state == 2)
            {
               var _loc3_:Number = 0 + _loc2_;
            }
         }
         return class_2724.clamp(0);
      }
      
      public function findTaskByAchievementId(param1:int) : class_3765
      {
         for each(var _loc2_ in var_1705)
         {
            if(_loc2_.achievementId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

