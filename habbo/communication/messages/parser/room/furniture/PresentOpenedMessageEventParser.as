package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PresentOpenedMessageEventParser implements IMessageParser
   {
      
      private var var_757:String;
      
      private var var_1015:int;
      
      private var var_2711:String;
      
      private var var_195:int;
      
      private var var_982:String;
      
      private var _placedInRoom:Boolean;
      
      private var _petFigureString:String;
      
      public function PresentOpenedMessageEventParser()
      {
         super();
      }
      
      public function get itemType() : String
      {
         return var_757;
      }
      
      public function get classId() : int
      {
         return var_1015;
      }
      
      public function get productCode() : String
      {
         return var_2711;
      }
      
      public function get placedItemId() : int
      {
         return var_195;
      }
      
      public function get placedItemType() : String
      {
         return var_982;
      }
      
      public function get placedInRoom() : Boolean
      {
         return _placedInRoom;
      }
      
      public function get petFigureString() : String
      {
         return _petFigureString;
      }
      
      public function flush() : Boolean
      {
         var_757 = "";
         var_1015 = 0;
         var_2711 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_757 = param1.readString();
         var_1015 = param1.readInteger();
         var_2711 = param1.readString();
         var_195 = param1.readInteger();
         var_982 = param1.readString();
         _placedInRoom = param1.readBoolean();
         _petFigureString = param1.readString();
         return true;
      }
   }
}

