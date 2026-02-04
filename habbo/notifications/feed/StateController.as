package com.sulake.habbo.notifications.feed
{
   public class StateController
   {
      
      private var var_3091:Boolean;
      
      private var var_1798:Boolean;
      
      private var var_1857:int = 0;
      
      private var var_2107:int = 1;
      
      public function StateController()
      {
         super();
      }
      
      private function isActive() : Boolean
      {
         return var_3091 && !var_1798;
      }
      
      public function setEnabled(param1:Boolean) : int
      {
         var_3091 = param1;
         if(!isActive())
         {
            return requestState(0);
         }
         return setVisible();
      }
      
      public function setGameMode(param1:Boolean) : int
      {
         var_1798 = param1;
         if(!isActive())
         {
            return requestState(0);
         }
         return setVisible();
      }
      
      public function currentState() : int
      {
         return var_1857;
      }
      
      public function requestState(param1:int) : int
      {
         if(!isActive())
         {
            var_2107 = param1;
            return var_1857;
         }
         var_1857 = param1;
         var_2107 = param1;
         return var_1857;
      }
      
      private function setVisible() : int
      {
         var _loc1_:int = var_2107;
         if(_loc1_ == 0)
         {
            _loc1_ = 1;
         }
         var_1857 = _loc1_;
         var_2107 = _loc1_;
         return _loc1_;
      }
   }
}

