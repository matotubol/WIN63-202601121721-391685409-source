package com.sulake.habbo.game.events
{
   import flash.events.Event;
   
   public class GameChatEvent extends Event
   {
      
      public static const GAME_CHAT:String = "gce_game_chat";
      
      private var var_1270:int;
      
      private var var_986:String;
      
      private var var_3909:int;
      
      private var _color:uint;
      
      private var var_975:String;
      
      private var var_111:String;
      
      private var _name:String;
      
      private var var_3938:int;
      
      private var var_1721:Boolean;
      
      public function GameChatEvent(param1:String, param2:int, param3:String, param4:int, param5:uint, param6:String, param7:String, param8:String, param9:int, param10:Boolean, param11:Boolean = false, param12:Boolean = false)
      {
         super(param1,param11,param12);
         var_1270 = param2;
         var_986 = param3;
         var_3909 = param4;
         _color = param5;
         var_975 = param6;
         var_111 = param7;
         _name = param8;
         var_3938 = param9;
         var_1721 = param10;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get message() : String
      {
         return var_986;
      }
      
      public function get locX() : int
      {
         return var_3909;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get gender() : String
      {
         return var_111;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get teamId() : int
      {
         return var_3938;
      }
      
      public function get notify() : Boolean
      {
         return var_1721;
      }
   }
}

