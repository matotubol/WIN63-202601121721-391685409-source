package com.sulake.habbo.communication.messages.parser.competition
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public class CompetitionEntrySubmitResultMessageEventParser implements IMessageParser
   {
      
      public static const const_1236:int = 0;
      
      public static const const_681:int = 1;
      
      public static const const_430:int = 2;
      
      public static const const_1015:int = 3;
      
      public static const const_1101:int = 4;
      
      public static const const_653:int = 5;
      
      public static const const_1092:int = 6;
      
      private var var_3122:int;
      
      private var var_897:String;
      
      private var var_1122:int;
      
      private var var_2468:Array;
      
      private var var_2616:Dictionary;
      
      public function CompetitionEntrySubmitResultMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2468 = null;
         var_2616 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3122 = param1.readInteger();
         var_897 = param1.readString();
         var_1122 = param1.readInteger();
         var_2468 = [];
         var _loc3_:int = param1.readInteger();
         var _loc2_:int = 0;
         while(0 < _loc3_)
         {
            var_2468.push(param1.readString());
            _loc2_++;
         }
         var_2616 = new Dictionary();
         _loc3_ = param1.readInteger();
         _loc2_ = 0;
         while(0 < _loc3_)
         {
            var_2616[param1.readString()] = "";
            _loc2_++;
         }
         return true;
      }
      
      public function get goalId() : int
      {
         return var_3122;
      }
      
      public function get goalCode() : String
      {
         return var_897;
      }
      
      public function get result() : int
      {
         return var_1122;
      }
      
      public function get requiredFurnis() : Array
      {
         return var_2468;
      }
      
      public function isMissing(param1:String) : Boolean
      {
         return var_2616[param1] != null;
      }
   }
}

