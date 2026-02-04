package com.sulake.core.window.graphics
{
   import com.sulake.core.window.graphics.renderer.*;
   import com.sulake.core.window.utils.DefaultAttStruct;
   import flash.utils.Dictionary;
   
   public class SkinContainer implements ISkinContainer
   {
      
      private static const MAX_STYLE_COUNT:uint = 100;
      
      protected static var statesByRenderPriority:Array;
      
      private var _disposed:Boolean = false;
      
      private var var_1148:Dictionary;
      
      private var var_1547:Dictionary;
      
      private var var_1604:Dictionary;
      
      private var var_1515:Dictionary;
      
      public function SkinContainer()
      {
         super();
         var_1148 = new Dictionary();
         var_1547 = new Dictionary();
         var_1604 = new Dictionary();
         var_1515 = new Dictionary();
         if(statesByRenderPriority == null)
         {
            statesByRenderPriority = [];
            statesByRenderPriority.push(64);
            statesByRenderPriority.push(32);
            statesByRenderPriority.push(16);
            statesByRenderPriority.push(8);
            statesByRenderPriority.push(4);
            statesByRenderPriority.push(2);
            statesByRenderPriority.push(1);
            statesByRenderPriority.push(0);
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         var_1148 = null;
         var_1547 = null;
         var_1604 = null;
         var_1515 = null;
         _disposed = true;
      }
      
      public function addSkinRenderer(param1:uint, param2:uint, param3:String, param4:ISkinRenderer, param5:XML, param6:DefaultAttStruct) : void
      {
         if(var_1148[param1] == null)
         {
            var_1148[param1] = new Array(100);
         }
         var_1148[param1][param2] = param4;
         if(var_1547[param1] == null)
         {
            var_1547[param1] = new Array(100);
         }
         var_1547[param1][param2] = param6;
         if(var_1604[param1] == null)
         {
            var_1604[param1] = new Array(100);
         }
         var_1604[param1][param2] = param5;
         if(var_1515[param1] == null)
         {
            var_1515[param1] = new Array(100);
         }
         var_1515[param1][param2] = param3 != null && param3.length > 0 ? param3 : param2.toString();
      }
      
      public function getSkinRendererByTypeAndStyle(param1:uint, param2:uint) : ISkinRenderer
      {
         var _loc4_:Array = var_1148[param1];
         if(_loc4_)
         {
            var _loc3_:ISkinRenderer = _loc4_[param2];
            if(param2 != 0)
            {
               _loc3_ = _loc4_[0];
            }
         }
         return null;
      }
      
      public function skinRendererExists(param1:uint, param2:uint) : Boolean
      {
         return var_1148[param1] && var_1148[param1][param2];
      }
      
      public function getDefaultAttributesByTypeAndStyle(param1:uint, param2:uint) : DefaultAttStruct
      {
         var _loc4_:Array = var_1547[param1];
         if(_loc4_)
         {
            var _loc3_:DefaultAttStruct = _loc4_[param2];
            if(param2 != 0)
            {
               _loc3_ = _loc4_[0];
            }
         }
         return null;
      }
      
      public function getWindowLayoutByTypeAndStyle(param1:uint, param2:uint) : XML
      {
         var _loc3_:Array = var_1604[param1];
         if(_loc3_ == null)
         {
            return null;
         }
         if(_loc3_[param2] == null)
         {
            return _loc3_[0];
         }
         return _loc3_[param2];
      }
      
      public function getIntentByTypeAndStyle(param1:uint, param2:uint) : String
      {
         var _loc3_:Array = var_1515[param1];
         return _loc3_ != null && _loc3_[param2] != null ? _loc3_[param2] : null;
      }
      
      public function getTheActualState(param1:uint, param2:uint, param3:uint) : uint
      {
         var _loc5_:int = 0;
         var _loc4_:ISkinRenderer = getSkinRendererByTypeAndStyle(param1,param2);
         if(_loc4_)
         {
            for each(_loc5_ in statesByRenderPriority)
            {
               if((param3 & _loc5_) == _loc5_)
               {
                  if(_loc4_.isStateDrawable(_loc5_))
                  {
                     return _loc5_;
                  }
               }
            }
         }
         return 0;
      }
   }
}

