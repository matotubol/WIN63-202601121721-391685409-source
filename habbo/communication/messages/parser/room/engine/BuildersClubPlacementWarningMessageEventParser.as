package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BuildersClubPlacementWarningMessageEventParser implements IMessageParser
   {
      
      public static var var_5240:int = 0;
      
      public static var var_5395:int = 1;
      
      private var var_2834:int;
      
      private var var_2228:int;
      
      private var _offerId:int;
      
      private var var_744:String;
      
      private var var_25:int;
      
      private var var_26:int;
      
      private var var_81:int;
      
      private var var_3429:String;
      
      public function BuildersClubPlacementWarningMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_2834 = param1.readInteger();
         var_2228 = param1.readInteger();
         _offerId = param1.readInteger();
         var_744 = param1.readString();
         if(var_2834 == var_5240)
         {
            var_25 = param1.readInteger();
            var_26 = param1.readInteger();
            var_81 = param1.readInteger();
         }
         else
         {
            var_3429 = param1.readString();
         }
         return true;
      }
      
      public function get typeCode() : int
      {
         return var_2834;
      }
      
      public function get pageId() : int
      {
         return var_2228;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get extraParam() : String
      {
         return var_744;
      }
      
      public function get x() : int
      {
         return var_25;
      }
      
      public function get y() : int
      {
         return var_26;
      }
      
      public function get direction() : int
      {
         return var_81;
      }
      
      public function get wallLocation() : String
      {
         return var_3429;
      }
   }
}

