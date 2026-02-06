package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class YoutubeDisplayPlaylistsMessageEventParser implements IMessageParser
   {
      
      private var var_2536:int;
      
      private var var_2282:Vector.<class_3334>;
      
      private var var_4323:String;
      
      public function YoutubeDisplayPlaylistsMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2282 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2536 = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         var_2282 = new Vector.<class_3334>(0);
         var _loc4_:int = 0;
         while(0 < _loc3_)
         {
            var _loc2_:String = param1.readString();
            var _loc6_:String = param1.readString();
            var _loc5_:String = param1.readString();
            var_2282.push(new class_3334(null,null,null));
            _loc4_++;
         }
         var_4323 = param1.readString();
         return true;
      }
      
      public function get furniId() : int
      {
         return var_2536;
      }
      
      public function get playlists() : Vector.<class_3334>
      {
         return var_2282;
      }
      
      public function get selectedPlaylistId() : String
      {
         return var_4323;
      }
   }
}

