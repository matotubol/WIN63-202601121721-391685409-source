package com.sulake.core.window.motion
{
   use namespace friend;
   
   public class Queue extends Motion
   {
      
      private var var_398:Motion;
      
      private var var_776:Vector.<Motion> = new Vector.<Motion>();
      
      public function Queue(... rest)
      {
         super(rest ? Motion(rest[0]).target : null);
         for each(var _loc2_ in rest)
         {
            var_776.push(_loc2_);
         }
         var_398 = rest[0];
         var_270 = var_398 == null;
      }
      
      override public function get running() : Boolean
      {
         return var_983 && var_398 ? var_398.running : false;
      }
      
      override friend function start() : void
      {
         super.friend::start();
         var_398.friend::start();
      }
      
      override friend function update(param1:Number) : void
      {
         super.friend::update(param1);
         if(var_398.running)
         {
            var_398.friend::update(param1);
         }
      }
      
      override friend function stop() : void
      {
         super.friend::stop();
         var_398.friend::stop();
      }
      
      override friend function tick(param1:int) : void
      {
         var _loc2_:int = 0;
         super.friend::tick(param1);
         var_398.friend::tick(param1);
         if(var_398.complete)
         {
            var_398.friend::stop();
            _loc2_ = int(var_776.indexOf(var_398));
            if(_loc2_ < var_776.length - 1)
            {
               var_398 = var_776[_loc2_ + 1];
               var_202 = var_398.target;
               var_398.friend::start();
            }
            else
            {
               var_270 = true;
            }
         }
      }
   }
}

