package package_203
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class WiredLogPage
   {
      
      private var var_3474:int;
      
      private var var_292:int;
      
      private var _amount:int;
      
      private var var_997:Vector.<WiredLogEntry>;
      
      private var var_2774:int;
      
      private var var_2789:int;
      
      private var var_3374:String;
      
      public function WiredLogPage(param1:IMessageDataWrapper)
      {
         super();
         var_3474 = param1.readInteger();
         var_292 = param1.readInteger();
         _amount = param1.readInteger();
         var_997 = new Vector.<WiredLogEntry>();
         var _loc2_:int = param1.readInteger();
         var _loc3_:* = 0;
         while(undefined < _loc2_)
         {
            var_997.push(new WiredLogEntry(param1));
            _loc3_ = undefined + 1;
         }
         var_2774 = -1;
         var_2789 = -1;
         var_3374 = null;
         if(param1.readBoolean())
         {
            var_2774 = param1.readByte();
         }
         if(param1.readBoolean())
         {
            var_2789 = param1.readByte();
         }
         if(param1.readBoolean())
         {
            var_3374 = param1.readString();
         }
      }
      
      public function get totalEntries() : int
      {
         return var_3474;
      }
      
      public function get currentPage() : int
      {
         return var_292;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get elements() : Vector.<WiredLogEntry>
      {
         return var_997;
      }
      
      public function get logLevelFilter() : int
      {
         return var_2774;
      }
      
      public function get logSourceFilter() : int
      {
         return var_2789;
      }
      
      public function get query() : String
      {
         return var_3374;
      }
   }
}

