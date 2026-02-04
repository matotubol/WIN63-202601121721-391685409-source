package com.sulake.core.window.utils
{
   import com.sulake.core.runtime.class_13;
   
   public class TextMargins implements IMargins, class_13
   {
      
      private var var_1335:int;
      
      private var var_1467:int;
      
      private var _top:int;
      
      private var var_1300:int;
      
      private var _callback:Function;
      
      private var _disposed:Boolean = false;
      
      public function TextMargins(param1:int, param2:int, param3:int, param4:int, param5:Function)
      {
         super();
         var_1335 = param1;
         _top = param2;
         var_1467 = param3;
         var_1300 = param4;
         _callback = param5 ?? nullCallback;
      }
      
      public function get left() : int
      {
         return var_1335;
      }
      
      public function get right() : int
      {
         return var_1467;
      }
      
      public function get top() : int
      {
         return _top;
      }
      
      public function get bottom() : int
      {
         return var_1300;
      }
      
      public function set left(param1:int) : void
      {
         var_1335 = param1;
         _callback(this);
      }
      
      public function set right(param1:int) : void
      {
         var_1467 = param1;
         _callback(this);
      }
      
      public function set top(param1:int) : void
      {
         _top = param1;
         _callback(this);
      }
      
      public function set bottom(param1:int) : void
      {
         var_1300 = param1;
         _callback(this);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get isZeroes() : Boolean
      {
         return var_1335 == 0 && var_1467 == 0 && _top == 0 && var_1300 == 0;
      }
      
      public function assign(param1:int, param2:int, param3:int, param4:int, param5:Function) : void
      {
         var_1335 = param1;
         _top = param2;
         var_1467 = param3;
         var_1300 = param4;
         _callback = param5 ?? nullCallback;
      }
      
      public function clone(param1:Function) : TextMargins
      {
         return new TextMargins(var_1335,_top,var_1467,var_1300,param1);
      }
      
      public function dispose() : void
      {
         _callback = null;
         _disposed = true;
      }
      
      private function nullCallback(param1:IMargins) : void
      {
      }
   }
}

