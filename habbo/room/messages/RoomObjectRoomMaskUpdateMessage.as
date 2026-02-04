package com.sulake.habbo.room.messages
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class RoomObjectRoomMaskUpdateMessage extends RoomObjectUpdateMessage
   {
      
      public static const ADD_MASK:String = "RORMUM_ADD_MASK";
      
      public static const REMOVE_MASK:String = "RORMUM_ADD_MASK";
      
      public static const MASK_TYPE_DOOR:String = "door";
      
      public static const MASK_CATEGORY_WINDOW:String = "window";
      
      public static const MASK_CATEGORY_HOLE:String = "hole";
      
      private var var_230:String = "";
      
      private var var_4950:String = "";
      
      private var var_5158:String = "";
      
      private var var_4646:Vector3d = null;
      
      private var var_4851:String = "window";
      
      public function RoomObjectRoomMaskUpdateMessage(param1:String, param2:String, param3:String = null, param4:IVector3d = null, param5:String = "window")
      {
         super(null,null);
         var_230 = param1;
         var_4950 = param2;
         var_5158 = param3;
         if(param4 != null)
         {
            var_4646 = new Vector3d(param4.x,param4.y,param4.z);
         }
         var_4851 = param5;
      }
      
      public function get type() : String
      {
         return var_230;
      }
      
      public function get maskId() : String
      {
         return var_4950;
      }
      
      public function get maskType() : String
      {
         return var_5158;
      }
      
      public function get maskLocation() : IVector3d
      {
         return var_4646;
      }
      
      public function get maskCategory() : String
      {
         return var_4851;
      }
   }
}

