package com.sulake.core.window.services
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1892;
   import flash.display.DisplayObject;
   
   public class ServiceManager implements IInternalWindowServices, class_13
   {
      
      private var var_5175:uint;
      
      private var var_134:DisplayObject;
      
      private var _disposed:Boolean = false;
      
      private var var_1050:class_1892;
      
      private var var_1903:IMouseDraggingService;
      
      private var var_1960:IMouseScalingService;
      
      private var var_1952:IMouseListenerService;
      
      private var var_1949:class_3746;
      
      private var var_1894:IToolTipAgentService;
      
      private var var_1793:class_3838;
      
      public function ServiceManager(param1:class_1892, param2:DisplayObject)
      {
         super();
         var_5175 = 0;
         var_134 = param2;
         var_1050 = param1;
         var_1903 = new WindowMouseDragger(param2);
         var_1960 = new WindowMouseScaler(param2);
         var_1952 = new WindowMouseListener(param2);
         var_1949 = new FocusManager(param2);
         var_1894 = new WindowToolTipAgent(param2);
         var_1793 = new GestureAgentService();
      }
      
      public function dispose() : void
      {
         if(var_1903 != null)
         {
            var_1903.dispose();
            var_1903 = null;
         }
         if(var_1960 != null)
         {
            var_1960.dispose();
            var_1960 = null;
         }
         if(var_1952 != null)
         {
            var_1952.dispose();
            var_1952 = null;
         }
         if(var_1949 != null)
         {
            var_1949.dispose();
            var_1949 = null;
         }
         if(var_1894 != null)
         {
            var_1894.dispose();
            var_1894 = null;
         }
         if(var_1793 != null)
         {
            var_1793.dispose();
            var_1793 = null;
         }
         var_134 = null;
         var_1050 = null;
         _disposed = true;
      }
      
      public function getMouseDraggingService() : IMouseDraggingService
      {
         return var_1903;
      }
      
      public function getMouseScalingService() : IMouseScalingService
      {
         return var_1960;
      }
      
      public function getMouseListenerService() : IMouseListenerService
      {
         return var_1952;
      }
      
      public function getFocusManagerService() : class_3746
      {
         return var_1949;
      }
      
      public function getToolTipAgentService() : IToolTipAgentService
      {
         return var_1894;
      }
      
      public function getGestureAgentService() : class_3838
      {
         return var_1793;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

