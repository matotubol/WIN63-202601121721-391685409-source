package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.furniture.class_1800;
   import flash.events.Event;
   
   public class CatalogViewer implements class_2109
   {
      
      private var _catalog:HabboCatalog;
      
      private var _container:class_1812;
      
      private var var_215:class_2044;
      
      private var _forceRefresh:Boolean;
      
      private var var_3749:int;
      
      public function CatalogViewer(param1:HabboCatalog, param2:class_1812)
      {
         super();
         _catalog = param1;
         _container = param2;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _catalog.roomEngine;
      }
      
      public function dispose() : void
      {
         if(var_215)
         {
            var_215.dispose();
            var_215 = null;
         }
         _catalog = null;
         _container = null;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function showCatalogPage(param1:int, param2:String, param3:class_1998, param4:Vector.<class_1793>, param5:int, param6:Boolean) : void
      {
         class_21.log("[Catalog Viewer] Show Catalog Page: " + [param1,param2,param4.length,param5]);
         if(var_215 != null)
         {
            if(!_forceRefresh && var_215.pageId == param1)
            {
               if(param5 > -1)
               {
                  var_215.selectOffer(param5);
               }
               return;
            }
            disposeCurrentPage();
         }
         var _loc7_:class_2044;
         var_215 = _loc7_ = new CatalogPage(this,param1,param2,param3,param4,_catalog,param6);
         var_3749 = param1 > -12345678 ? param1 : var_3749;
         if(_loc7_.window != null)
         {
            _container.addChild(_loc7_.window);
            _loc7_.window.height = _container.height;
            _container.width = _loc7_.window.width;
            _container.x = _container.parent.width - _container.width - 8;
            if(_container.x < 130)
            {
               _catalog.setLeftPaneVisibility(false);
            }
            else
            {
               _catalog.setLeftPaneVisibility(true);
            }
         }
         else
         {
            class_21.log("[CatalogViewer] No window for page: " + param2);
         }
         _container.visible = true;
         _forceRefresh = false;
         _loc7_.selectOffer(param5);
      }
      
      public function disposeCurrentPage() : void
      {
         if(var_215 != null)
         {
            _container.removeChild(var_215.window);
            var_215.dispose();
            _container.invalidate();
         }
      }
      
      public function catalogWindowClosed() : void
      {
         if(var_215 != null)
         {
            var_215.closed();
         }
      }
      
      public function dispatchWidgetEvent(param1:Event) : Boolean
      {
         return var_215.dispatchWidgetEvent(param1);
      }
      
      public function getCurrentLayoutCode() : String
      {
         if(var_215 == null)
         {
            return "";
         }
         return var_215.layoutCode;
      }
      
      public function get currentPage() : class_2044
      {
         return var_215;
      }
      
      public function showSearchResults(param1:Vector.<class_1800>) : void
      {
         var _loc3_:class_1793 = null;
         if(var_215 != null)
         {
            _container.removeChild(var_215.window);
            var_215.dispose();
         }
         var _loc2_:Vector.<class_1793> = new Vector.<class_1793>(0);
         for each(var _loc5_ in param1)
         {
            _loc3_ = new FurnitureOffer(_loc5_,_catalog);
            _loc2_.push(_loc3_);
         }
         var _loc4_:class_2044;
         var_215 = _loc4_ = new CatalogPage(this,-1,"default_3x3",new PageLocalization(["catalog_header_roombuilder","credits_v3_teaser"],["${catalog.search.results}"]),_loc2_,_catalog,false,1);
         if(_loc4_.window != null)
         {
            _container.addChild(_loc4_.window);
            _loc4_.window.width = _container.width;
            _loc4_.window.height = _container.height;
         }
         else
         {
            class_21.log("[CatalogViewer] No window for page: <SEARCH>");
         }
         _container.visible = true;
      }
      
      public function get viewerTags() : Array
      {
         return _container ? _container.tags : [];
      }
      
      public function setForceRefresh() : void
      {
         _forceRefresh = true;
      }
      
      public function get previousPageId() : int
      {
         return var_3749;
      }
   }
}

