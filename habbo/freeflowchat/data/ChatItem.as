package com.sulake.habbo.freeflowchat.data
{
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.room.utils.IVector3d;
   
   public class ChatItem
   {
      
      private var var_2857:int = 0;
      
      private var var_1270:int = 0;
      
      private var var_1951:int = 0;
      
      private var _text:String = "";
      
      private var var_665:int = 0;
      
      private var var_2621:Array;
      
      private var _style:int;
      
      private var var_4184:IVector3d;
      
      private var _forcedColor:*;
      
      private var var_4068:*;
      
      private var var_4810:String;
      
      private var _forcedUserName:String;
      
      private var var_744:int;
      
      public function ChatItem(param1:RoomSessionChatEvent, param2:int, param3:IVector3d = null, param4:int = 0, param5:* = null, param6:* = null, param7:String = null, param8:String = null)
      {
         super();
         var_2857 = param2;
         var_4184 = param3;
         var_1270 = param1.userId;
         if(param1.session)
         {
            var_1951 = param1.session.roomId;
         }
         else
         {
            var_1951 = 1;
         }
         _text = param1.text;
         var_665 = param1.chatType;
         _style = param1.style;
         var_2621 = new Array(param1.links);
         _forcedColor = param6;
         var_4068 = param5;
         var_4810 = param7;
         _forcedUserName = param8;
         var_744 = param4;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get chatType() : int
      {
         return var_665;
      }
      
      public function get links() : Array
      {
         return var_2621;
      }
      
      public function get style() : int
      {
         return _style;
      }
      
      public function get timeStamp() : uint
      {
         return var_2857;
      }
      
      public function get userLocation() : IVector3d
      {
         return var_4184;
      }
      
      public function get forcedColor() : *
      {
         return _forcedColor;
      }
      
      public function get forcedScreenLocation() : *
      {
         return var_4068;
      }
      
      public function get forcedFigure() : String
      {
         return var_4810;
      }
      
      public function get forcedUserName() : String
      {
         return _forcedUserName;
      }
      
      public function get extraParam() : int
      {
         return var_744;
      }
      
      public function set text(param1:String) : void
      {
         _text = param1;
      }
   }
}

