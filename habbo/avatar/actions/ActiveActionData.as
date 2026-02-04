package com.sulake.habbo.avatar.actions
{
   public class ActiveActionData implements class_2501
   {
      
      private var var_2265:String = "";
      
      private var var_1331:String = "";
      
      private var var_2012:class_2768;
      
      private var _startFrame:int = 0;
      
      private var _overridingAction:String;
      
      public function ActiveActionData(param1:String, param2:String = "", param3:int = 0)
      {
         super();
         var_2265 = param1;
         var_1331 = param2;
         _startFrame = param3;
      }
      
      public function get actionType() : String
      {
         return var_2265;
      }
      
      public function get actionParameter() : String
      {
         return var_1331;
      }
      
      public function get definition() : class_2768
      {
         return var_2012;
      }
      
      public function get id() : String
      {
         if(var_2012 == null)
         {
            return "";
         }
         return var_2012.id + "_" + var_1331;
      }
      
      public function set actionParameter(param1:String) : void
      {
         var_1331 = param1;
      }
      
      public function set definition(param1:class_2768) : void
      {
         var_2012 = param1;
      }
      
      public function dispose() : void
      {
         var_2265 = null;
         var_1331 = null;
         var_2012 = null;
      }
      
      public function get startFrame() : int
      {
         return _startFrame;
      }
      
      public function get overridingAction() : String
      {
         return _overridingAction;
      }
      
      public function set overridingAction(param1:String) : void
      {
         _overridingAction = param1;
      }
      
      public function toString() : String
      {
         return "Action: " + var_2265 + "  param: " + var_1331;
      }
   }
}

