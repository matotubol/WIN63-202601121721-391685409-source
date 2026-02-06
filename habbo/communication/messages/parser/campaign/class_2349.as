package com.sulake.habbo.communication.messages.parser.campaign
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2349
   {
      
      private var var_2308:String;
      
      private var var_2491:String;
      
      private var var_2318:int;
      
      private var var_2275:int;
      
      private var var_1794:Vector.<int>;
      
      private var var_1964:Vector.<int>;
      
      public function class_2349()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2308 = param1.readString();
         var_2491 = param1.readString();
         var_2318 = param1.readInteger();
         var_2275 = param1.readInteger();
         var_1794 = new Vector.<int>(0);
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         var_1964 = new Vector.<int>(0);
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         return true;
      }
      
      public function clone() : class_2349
      {
         var _loc1_:class_2349 = new class_2349();
         _loc1_.campaignDays = var_2275;
         _loc1_.campaignImage = var_2491;
         _loc1_.campaignName = var_2308;
         _loc1_.currentDay = var_2318;
         _loc1_.missedDays = var_1964;
         _loc1_.openedDays = var_1794;
         return _loc1_;
      }
      
      public function get campaignName() : String
      {
         return var_2308;
      }
      
      public function get campaignImage() : String
      {
         return var_2491;
      }
      
      public function get currentDay() : int
      {
         return var_2318;
      }
      
      public function get campaignDays() : int
      {
         return var_2275;
      }
      
      public function get openedDays() : Vector.<int>
      {
         return var_1794;
      }
      
      public function get missedDays() : Vector.<int>
      {
         return var_1964;
      }
      
      public function set campaignName(param1:String) : void
      {
         var_2308 = param1;
      }
      
      public function set campaignImage(param1:String) : void
      {
         var_2491 = param1;
      }
      
      public function set currentDay(param1:int) : void
      {
         var_2318 = param1;
      }
      
      public function set campaignDays(param1:int) : void
      {
         var_2275 = param1;
      }
      
      public function set openedDays(param1:Vector.<int>) : void
      {
         var_1794 = param1;
      }
      
      public function set missedDays(param1:Vector.<int>) : void
      {
         var_1964 = param1;
      }
   }
}

