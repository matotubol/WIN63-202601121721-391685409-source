package com.sulake.habbo.freeflowchat.history.visualization.entry
{
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.history.visualization.enum.class_2964;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1945;
   
   public class ChatHistoryRoomChangeEntry implements class_2434
   {
      
      private static const TOP_MARGIN_HEIGHT:int = 4;
      
      private var _bitmap:BitmapData;
      
      private var _overlap:Rectangle = new Rectangle(0,0,0,0);
      
      public function ChatHistoryRoomChangeEntry(param1:class_1945, param2:HabboFreeFlowChat)
      {
         super();
         var _loc4_:TextField = new TextField();
         _loc4_.defaultTextFormat = class_2964.TEXT_FORMAT;
         _loc4_.htmlText = param1?.roomName;
         _loc4_.width = _loc4_.textWidth + 5;
         _loc4_.height = _loc4_.textHeight + 5;
         _loc4_.thickness = -15;
         _loc4_.sharpness = 80;
         _loc4_.antiAliasType = "advanced";
         _loc4_.embedFonts = true;
         _loc4_.gridFitType = "pixel";
         var _loc3_:TextField = new TextField();
         _loc3_.defaultTextFormat = class_2964.TEXT_FORMAT_TIMESTAMP;
         _loc3_.text = HabboFreeFlowChat.getTimeStampNow();
         _loc3_.width = _loc3_.textWidth + 5;
         _loc3_.height = _loc3_.textHeight + 5;
         _loc3_.thickness = -15;
         _loc3_.sharpness = 80;
         _loc3_.antiAliasType = "advanced";
         _loc3_.embedFonts = true;
         _loc3_.gridFitType = "pixel";
         _bitmap = new BitmapData(415,_loc4_.textHeight + 5 + 8 + 4,true,0);
         _bitmap.copyPixels(param2.getRoomChangeBitmap(),param2.getRoomChangeBitmap().rect,new Point(62,1 + 4));
         _bitmap.draw(_loc3_,new Matrix(1,0,0,1,0,4));
         _bitmap.draw(_loc4_,new Matrix(1,0,0,1,62 + 20,4));
      }
      
      public function get bitmap() : BitmapData
      {
         return _bitmap;
      }
      
      public function get overlap() : Rectangle
      {
         return _overlap;
      }
      
      public function get userId() : int
      {
         return -1;
      }
      
      public function get roomId() : int
      {
         return -1;
      }
      
      public function get canIgnore() : Boolean
      {
         return false;
      }
      
      public function get userName() : String
      {
         return "";
      }
   }
}

