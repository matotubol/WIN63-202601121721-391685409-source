package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import flash.geom.Rectangle;
   
   public class ActivatorController extends ContainerController
   {
      
      protected var var_1661:class_1741;
      
      public function ActivatorController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      override public function update(param1:WindowController, param2:class_1758) : Boolean
      {
         if(param2.type == "WE_CHILD_ACTIVATED")
         {
            setActiveChild(param1 as class_1741);
         }
         else if(param2.type == "WE_PARENT_ACTIVATED")
         {
            return true;
         }
         return super.update(param1,param2);
      }
      
      public function getActiveChild() : class_1741
      {
         return var_1661;
      }
      
      public function setActiveChild(param1:class_1741) : class_1741
      {
         if(param1.parent != this)
         {
            do
            {
               param1 = param1.parent;
               if(param1 == null)
               {
                  throw new Error("Window passed to activator is not a child!");
               }
            }
            while(param1.parent != this);
            
         }
         var _loc2_:class_1741 = var_1661;
         if(var_1661 != param1)
         {
            if(var_1661 != null)
            {
               if(!var_1661.disposed)
               {
                  var_1661.deactivate();
               }
            }
            var_1661 = param1;
            if(getChildIndex(param1) != numChildren - 1)
            {
               setChildIndex(param1,numChildren - 1);
            }
         }
         return _loc2_;
      }
   }
}

