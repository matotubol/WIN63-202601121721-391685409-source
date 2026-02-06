package com.sulake.habbo.communication.messages.parser.talent
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TalentLevelUpMessageEventParser implements IMessageParser
   {
      
      private var var_2988:String;
      
      private var var_2493:int;
      
      private var var_2622:Vector.<class_4056>;
      
      private var var_2332:Vector.<class_3878>;
      
      public function TalentLevelUpMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2988 = null;
         var_2622 = null;
         var_2332 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2988 = param1.readString();
         var_2493 = param1.readInteger();
         var_2622 = new Vector.<class_4056>();
         var _loc4_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc4_)
         {
            var_2622.push(new class_4056(param1));
            _loc3_++;
         }
         var_2332 = new Vector.<class_3878>();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(0 < _loc2_)
         {
            var_2332.push(new class_3878(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get talentTrackName() : String
      {
         return var_2988;
      }
      
      public function get level() : int
      {
         return var_2493;
      }
      
      public function get rewardPerks() : Vector.<class_4056>
      {
         return var_2622;
      }
      
      public function get rewardProducts() : Vector.<class_3878>
      {
         return var_2332;
      }
   }
}

