package com.sulake.habbo.messenger
{
   import flash.utils.getTimer;
   
   public class ChatEntry
   {
      
      public static const TYPE_OWN_CHAT:int = 1;
      
      public static const TYPE_OTHER_CHAT:int = 2;
      
      public static const const_271:int = 3;
      
      public static const TYPE_INFO:int = 4;
      
      public static const const_313:int = 5;
      
      private var var_230:int;
      
      private var var_4642:int;
      
      private var var_986:String;
      
      private var var_3850:int;
      
      private var _clientReceiveTime:int;
      
      private var var_2574:int;
      
      private var var_2915:String;
      
      private var var_1229:int;
      
      private var _senderName:String;
      
      private var var_2792:String;
      
      public function ChatEntry(param1:int, param2:int, param3:String, param4:int, param5:int = 0, param6:String = null, param7:String = null, param8:String = "", param9:int = 0)
      {
         super();
         var_230 = param1;
         var_4642 = param2;
         var_986 = param3;
         var_3850 = param4;
         _clientReceiveTime = getTimer();
         var_2574 = param9;
         var_2915 = param8;
         var_1229 = param5;
         _senderName = param6;
         var_2792 = param7;
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function get chatId() : int
      {
         return var_4642;
      }
      
      public function get message() : String
      {
         return var_986;
      }
      
      public function get secondsSinceSent() : int
      {
         var _loc1_:int = (getTimer() - _clientReceiveTime) / 1000;
         return var_3850 + _loc1_;
      }
      
      public function sentTimeStamp() : Number
      {
         return new Date().getTime() - secondsSinceSent * 1000;
      }
      
      public function prefixMessageWith(param1:String) : void
      {
         var_986 = param1 + "\n" + var_986;
      }
      
      public function get awaitConfirmationId() : int
      {
         return var_2574;
      }
      
      public function isAwaitingConfirmation() : Boolean
      {
         return var_2574 != 0;
      }
      
      public function isConfirmed(param1:String, param2:String) : void
      {
         var_2574 = 0;
         var_986 = param1;
         var_2915 = param2;
      }
      
      public function get messageId() : String
      {
         return var_2915;
      }
      
      public function get senderId() : int
      {
         return var_1229;
      }
      
      public function get senderName() : String
      {
         return _senderName;
      }
      
      public function get senderFigure() : String
      {
         return var_2792;
      }
   }
}

