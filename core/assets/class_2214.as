package com.sulake.core.assets
{
   import com.sulake.core.class_23;
   import com.sulake.core.runtime.class_31;
   
   public class class_2214 implements class_31
   {
      
      private var var_776:Vector.<ILazyAsset> = new Vector.<ILazyAsset>();
      
      private var var_983:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function class_2214()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            class_23.instance.removeUpdateReceiver(this);
            var_776 = null;
            var_983 = false;
            _disposed = true;
         }
      }
      
      public function push(param1:ILazyAsset) : void
      {
         if(param1)
         {
            var_776.push(param1);
            if(!var_983)
            {
               class_23.instance.registerUpdateReceiver(this,2);
               var_983 = true;
            }
         }
      }
      
      public function flush() : void
      {
         for each(var _loc1_ in var_776)
         {
            if(!_loc1_.disposed)
            {
               _loc1_.prepareLazyContent();
            }
         }
         var_776 = new Vector.<ILazyAsset>();
         if(var_983)
         {
            class_23.instance.removeUpdateReceiver(this);
            var_983 = false;
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:ILazyAsset = var_776.shift();
         if(!_loc2_)
         {
            if(var_983)
            {
               class_23.instance.removeUpdateReceiver(this);
               var_983 = false;
            }
         }
         else if(!_loc2_.disposed)
         {
            _loc2_.prepareLazyContent();
         }
      }
   }
}

