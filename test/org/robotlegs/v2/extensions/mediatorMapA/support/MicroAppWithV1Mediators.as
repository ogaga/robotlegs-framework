//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package org.robotlegs.v2.extensions.mediatorMapA.support
{
	import org.robotlegs.v2.core.impl.ContextBuilder;
	import flash.display.Sprite;
	import org.swiftsuspenders.Injector;
	import org.robotlegs.v2.extensions.mediatorMapA.api.IMediatorMap;
	import flash.display.MovieClip;
	import org.robotlegs.v2.core.api.ContextBuilderEvent;
	import org.robotlegs.v2.extensions.mediatorMapA.impl.support.MediatorWatcher;
	import org.robotlegs.v2.extensions.mediatorMapA.bundles.RL1MediatorsMediatorMapBundle;
	import org.robotlegs.v2.extensions.mediatorMapA.support.TracingV1Mediator;

	public class MicroAppWithV1Mediators extends Sprite
	{
	
		protected var _mediatorWatcher:MediatorWatcher;
	
		public function buildContext(completeHandler:Function, mediatorWatcher:MediatorWatcher):void
		{
			_mediatorWatcher = mediatorWatcher;
			
			const contextBuilder:ContextBuilder = new ContextBuilder();

			contextBuilder.addEventListener(ContextBuilderEvent.CONTEXT_BUILD_COMPLETE, addMappings);
			contextBuilder.addEventListener(ContextBuilderEvent.CONTEXT_BUILD_COMPLETE, completeHandler);
			
			// eventually this would be done with a bundle
			
			contextBuilder.withContextView(this)
									.withDispatcher(this)
									.withInjector(new Injector())
									.withBundle(RL1MediatorsMediatorMapBundle)
									.build();
		}	

		protected function addMappings(e:ContextBuilderEvent):void
		{
			const mediatorMapA:IMediatorMap = e.context.injector.getInstance(IMediatorMap);
			mediatorMapA.map(TracingV1Mediator).toView(MovieClip);
			
			e.context.injector.map(MediatorWatcher).toValue(_mediatorWatcher);
		}
	}
}