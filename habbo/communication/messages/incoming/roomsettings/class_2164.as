package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2164
   {
      
      public static const const_128:int = 0;
      
      public static const const_481:int = 1;
      
      public static const const_831:int = 0;
      
      public static const const_911:int = 1;
      
      public static const const_914:int = 2;
      
      public static const const_274:int = 0;
      
      public static const const_716:int = 1;
      
      public static const const_997:int = 2;
      
      public static const const_189:int = 0;
      
      public static const const_1002:int = 1;
      
      public static const const_711:int = 2;
      
      private var var_261:int = 0;
      
      private var var_3959:int = 1;
      
      private var var_4987:int = 1;
      
      private var var_4906:int = 1;
      
      private var var_4585:int = 14;
      
      public function class_2164(param1:IMessageDataWrapper)
      {
         super();
         var_261 = param1.readInteger();
         var_3959 = param1.readInteger();
         var_4987 = param1.readInteger();
         var_4585 = param1.readInteger();
         var_4906 = param1.readInteger();
      }
      
      public function get mode() : int
      {
         return var_261;
      }
      
      public function get bubbleWidth() : int
      {
         return var_3959;
      }
      
      public function get scrollSpeed() : int
      {
         return var_4987;
      }
      
      public function get fullHearRange() : int
      {
         return var_4585;
      }
      
      public function get floodSensitivity() : int
      {
         return var_4906;
      }
   }
}

