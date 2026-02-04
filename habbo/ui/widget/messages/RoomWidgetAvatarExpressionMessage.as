package com.sulake.habbo.ui.widget.messages
{
   import com.sulake.habbo.ui.widget.enums.AvatarExpressionEnum;
   
   public class RoomWidgetAvatarExpressionMessage extends RoomWidgetMessage
   {
      
      public static const const_209:String = "RWCM_MESSAGE_AVATAR_EXPRESSION";
      
      private var var_2040:AvatarExpressionEnum;
      
      public function RoomWidgetAvatarExpressionMessage(param1:AvatarExpressionEnum)
      {
         super("RWCM_MESSAGE_AVATAR_EXPRESSION");
         var_2040 = param1;
      }
      
      public function get animation() : AvatarExpressionEnum
      {
         return var_2040;
      }
   }
}

