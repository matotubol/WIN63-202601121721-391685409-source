package com.sulake.habbo.communication.messages.parser.talent
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3765
   {
      
      public static const const_874:String = "ACH_HabboWayGraduate1";
      
      public static const const_641:String = "ACH_GuideGroupMember1";
      
      public static const const_636:String = "ACH_SafetyQuizGraduate1";
      
      public static const const_564:String = "ACH_EmailVerification1";
      
      public static const ROOM_ENTRY_1:String = "ACH_RoomEntry1";
      
      public static const ROOM_ENTRY_2:String = "ACH_RoomEntry2";
      
      public static const const_1040:String = "ACH_AvatarLooks1";
      
      public static const const_290:String = "ACH_GuideAdvertisementReader1";
      
      private var var_2755:int;
      
      private var var_3223:int;
      
      private var var_2806:String;
      
      private var var_61:int;
      
      private var var_4321:int;
      
      private var var_4436:int;
      
      public function class_3765(param1:IMessageDataWrapper)
      {
         super();
         var_2755 = param1.readInteger();
         var_3223 = param1.readInteger();
         var_2806 = param1.readString();
         var_61 = param1.readInteger();
         var_4321 = param1.readInteger();
         var_4436 = param1.readInteger();
      }
      
      public function get state() : int
      {
         return var_61;
      }
      
      public function get achievementId() : int
      {
         return var_2755;
      }
      
      public function get requiredLevel() : int
      {
         return var_3223;
      }
      
      public function get badgeCode() : String
      {
         return var_2806;
      }
      
      public function get currentScore() : int
      {
         return var_4321;
      }
      
      public function get totalScore() : int
      {
         return var_4436;
      }
      
      public function hasProgressDisplay() : Boolean
      {
         switch(badgeCode)
         {
            case "ACH_HabboWayGraduate1":
            case "ACH_SafetyQuizGraduate1":
            case "ACH_EmailVerification1":
            case "ACH_AvatarLooks1":
               return false;
            default:
               return true;
         }
      }
   }
}

