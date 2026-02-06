package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuildFurniContextMenuInfoMessageEventParser implements IMessageParser
   {
      
      private var var_315:int;
      
      private var var_3004:int;
      
      private var var_3202:String;
      
      private var var_2816:int;
      
      private var var_3215:Boolean;
      
      private var var_2695:Boolean;
      
      public function GuildFurniContextMenuInfoMessageEventParser()
      {
         super();
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
      
      public function get guildId() : int
      {
         return var_3004;
      }
      
      public function get guildName() : String
      {
         return var_3202;
      }
      
      public function get guildHomeRoomId() : int
      {
         return var_2816;
      }
      
      public function get userIsMember() : Boolean
      {
         return var_3215;
      }
      
      public function get guildHasReadableForum() : Boolean
      {
         return var_2695;
      }
      
      public function flush() : Boolean
      {
         var_315 = -1;
         var_3004 = -1;
         var_3202 = "";
         var_2816 = -1;
         var_3215 = false;
         var_2695 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_315 = param1.readInteger();
         var_3004 = param1.readInteger();
         var_3202 = param1.readString();
         var_2816 = param1.readInteger();
         var_3215 = param1.readBoolean();
         var_2695 = param1.readBoolean();
         return true;
      }
   }
}

