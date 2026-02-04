package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetSongUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const SONG_PLAYING_CHANGED:String = "RWSUE_PLAYING_CHANGED";
      
      public static const SONG_DATA_RECEIVED:String = "RWSUE_DATA_RECEIVED";
      
      private var var_2766:int;
      
      private var _songName:String;
      
      private var var_4431:String;
      
      public function RoomWidgetSongUpdateEvent(param1:String, param2:int, param3:String, param4:String, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         var_2766 = param2;
         _songName = param3;
         var_4431 = param4;
      }
      
      public function get songId() : int
      {
         return var_2766;
      }
      
      public function get songName() : String
      {
         return _songName;
      }
      
      public function get songAuthor() : String
      {
         return var_4431;
      }
   }
}

