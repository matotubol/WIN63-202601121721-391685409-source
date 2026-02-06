package com.sulake.habbo.communication.messages.incoming.callforhelp
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.communication.messages.incoming.moderation.class_2217;
   
   [SecureSWF(rename="true")]
   public class class_2218 implements class_2217, class_13
   {
      
      private var _name:String;
      
      private var var_2288:Vector.<class_3499>;
      
      private var _disposed:Boolean;
      
      public function class_2218(param1:IMessageDataWrapper)
      {
         super();
         var_2288 = new Vector.<class_3499>();
         _name = param1.readString();
         var _loc3_:int = param1.readInteger();
         var _loc2_:int = 0;
         while(0 < _loc3_)
         {
            var_2288.push(new class_3499(param1));
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         var_2288 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get topics() : Vector.<class_3499>
      {
         return var_2288;
      }
   }
}

