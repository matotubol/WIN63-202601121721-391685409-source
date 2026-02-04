package com.sulake.habbo.help.guidehelp
{
   public class GuideSessionData
   {
      
      public static const ROLE_UNDECIDED:uint = 0;
      
      public static const ROLE_GUIDE:uint = 1;
      
      public static const ROLE_USER:uint = 2;
      
      public static const const_1145:int = 0;
      
      public static const const_1050:int = 1;
      
      public static const const_141:int = 2;
      
      private var var_3458:uint = 0;
      
      private var var_861:String = "";
      
      private var var_1282:uint = 0;
      
      private var var_4860:String = "";
      
      private var var_1270:uint = 0;
      
      private var _userName:String = "";
      
      private var var_4564:String = "";
      
      private var var_1931:uint = 0;
      
      private var _guideName:String = "";
      
      private var var_3855:String = "";
      
      public function GuideSessionData()
      {
         super();
      }
      
      public function isActiveSession() : Boolean
      {
         return isActiveUserSession() || isActiveGuideSession();
      }
      
      public function isActiveUserSession() : Boolean
      {
         return var_3458 == 2 && (var_861 == "user_create" || var_861 == "user_pending" || var_861 == "user_ongoing" || var_861 == "user_feedback");
      }
      
      public function isActiveGuideSession() : Boolean
      {
         return var_3458 == 1 && (var_861 == "guide_accept" || var_861 == "guide_ongoing" || var_861 == "guide_closed");
      }
      
      public function isOnGoingSession() : Boolean
      {
         return var_861 == "guide_ongoing" || var_861 == "user_ongoing";
      }
      
      public function set role(param1:uint) : void
      {
         var_3458 = param1;
      }
      
      public function get activeWindow() : String
      {
         return var_861;
      }
      
      public function set activeWindow(param1:String) : void
      {
         var_861 = param1;
      }
      
      public function get requestType() : uint
      {
         return var_1282;
      }
      
      public function set requestType(param1:uint) : void
      {
         var_1282 = param1;
      }
      
      public function get requestDescription() : String
      {
         return var_4860;
      }
      
      public function set requestDescription(param1:String) : void
      {
         var_4860 = param1;
      }
      
      public function get userId() : uint
      {
         return var_1270;
      }
      
      public function set userId(param1:uint) : void
      {
         var_1270 = param1;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function set userName(param1:String) : void
      {
         _userName = param1;
      }
      
      public function get userFigure() : String
      {
         return var_4564;
      }
      
      public function set userFigure(param1:String) : void
      {
         var_4564 = param1;
      }
      
      public function get guideId() : uint
      {
         return var_1931;
      }
      
      public function set guideId(param1:uint) : void
      {
         var_1931 = param1;
      }
      
      public function get guideName() : String
      {
         return _guideName;
      }
      
      public function set guideName(param1:String) : void
      {
         _guideName = param1;
      }
      
      public function get guideFigure() : String
      {
         return var_3855;
      }
      
      public function set guideFigure(param1:String) : void
      {
         var_3855 = param1;
      }
   }
}

