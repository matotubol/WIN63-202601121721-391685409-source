package com.sulake.core.window.motion
{
   use namespace friend;
   
   public class Combo extends Motion
   {
      
      private var var_1130:Vector.<Motion> = new Vector.<Motion>();
      
      private var var_2958:Vector.<Motion> = new Vector.<Motion>();
      
      public function Combo(... rest)
      {
         for each(var _loc2_ in rest)
         {
            var_1130.push(_loc2_);
         }
         super(var_1130.length > 0 ? var_1130[0].target : null);
      }
      
      override friend function start() : void
      {
         super.friend::start();
         for each(var _loc1_ in var_1130)
         {
            _loc1_.friend::start();
         }
      }
      
      override friend function tick(param1:int) : void
      {
         var _loc2_:Motion = null;
         super.friend::tick(param1);
         while(true)
         {
            _loc2_ = var_2958.pop();
            if(_loc2_ == null)
            {
               break;
            }
            var_1130.splice(var_2958.indexOf(_loc2_),1);
            if(_loc2_.running)
            {
               _loc2_.friend::stop();
            }
         }
         for each(_loc2_ in var_1130)
         {
            if(_loc2_.running)
            {
               _loc2_.friend::tick(param1);
            }
            if(_loc2_.complete)
            {
               var_2958.push(_loc2_);
            }
         }
         if(var_1130.length > 0)
         {
            for each(_loc2_ in var_1130)
            {
               var_202 = _loc2_.target;
               if(var_202 && !var_202.disposed)
               {
                  break;
               }
            }
            var_270 = false;
         }
         else
         {
            var_270 = true;
         }
      }
   }
}

