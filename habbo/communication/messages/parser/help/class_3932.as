package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_3932 implements IMessageParser
   {
      
      public static const const_492:int = 0;
      
      public static const const_1165:int = 1;
      
      public static const const_464:int = 2;
      
      public static const const_619:int = 3;
      
      public static const const_768:int = 4;
      
      public static const const_435:int = 5;
      
      private var _status:Array;
      
      public function class_3932()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _status = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _status = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            _status.push(param1.readInteger());
            _loc3_++;
         }
         return true;
      }
      
      public function get status() : Array
      {
         return _status;
      }
   }
}

