package com.sulake.habbo.communication.messages.parser.game.directory
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class Game2JoiningGameFailedMessageParser implements IMessageParser
   {
      
      public static const const_513:int = 1;
      
      public static const const_947:int = 2;
      
      public static const const_1180:int = 3;
      
      public static const const_311:int = 4;
      
      public static const const_787:int = 5;
      
      public static const const_610:int = 6;
      
      public static const const_245:int = 7;
      
      public static const const_884:int = 8;
      
      private var var_2352:int;
      
      public function Game2JoiningGameFailedMessageParser()
      {
         super();
      }
      
      public function get reason() : int
      {
         return var_2352;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2352 = param1.readInteger();
         return true;
      }
   }
}

