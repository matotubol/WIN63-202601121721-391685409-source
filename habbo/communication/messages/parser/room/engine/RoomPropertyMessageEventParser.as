package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomPropertyMessageEventParser implements IMessageParser
   {
      
      private var var_2808:String = null;
      
      private var var_2865:String = null;
      
      private var var_2981:String = null;
      
      private var var_3057:String = null;
      
      public function RoomPropertyMessageEventParser()
      {
         super();
      }
      
      public function get floorType() : String
      {
         return var_2808;
      }
      
      public function get wallType() : String
      {
         return var_2865;
      }
      
      public function get landscapeType() : String
      {
         return var_2981;
      }
      
      public function get animatedLandscapeType() : String
      {
         return var_3057;
      }
      
      public function flush() : Boolean
      {
         var_2808 = null;
         var_2865 = null;
         var_2981 = null;
         var_3057 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:String = param1.readString();
         var _loc2_:String = param1.readString();
         switch(_loc3_)
         {
            case "floor":
               var_2808 = _loc2_;
               break;
            case "wallpaper":
               var_2865 = _loc2_;
               break;
            case "landscape":
               var_2981 = _loc2_;
               break;
            case "landscapeanim":
               var_3057 = _loc2_;
         }
         return true;
      }
   }
}

