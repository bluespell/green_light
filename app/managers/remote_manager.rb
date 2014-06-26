class RemoteManager
  class << self
    include CDQ

    def setup
      cdq.setup

      RKObjectManager.sharedManager = manager
    end

    def object_manager
      RKObjectManager.sharedManager
    end

    private

    def manager
      Dispatch.once do
        @manager = RKObjectManager.managerWithBaseURL(NSURL.URLWithString('https://semaphoreapp.com/api/v1/'))
        @manager.managedObjectStore = store
        @manager.addResponseDescriptor(project_response_descriptor)
      end
      @manager
    end

    def store
      Dispatch.once do
        @store = RKManagedObjectStore.alloc.initWithPersistentStoreCoordinator(cdq.stores.current)
        @store.createManagedObjectContexts
        cdq.contexts.push(@store.persistentStoreManagedObjectContext)
        cdq.contexts.push(@store.mainQueueManagedObjectContext)
      end
      @store
    end

    # Project mapping

    def project_response_descriptor
      Dispatch.once do
        @project_response_descriptor = RKResponseDescriptor.responseDescriptorWithMapping(
          project_mapping,
          method: RKRequestMethodAny,
          pathPattern: 'projects.json',
          keyPath: '',
          statusCodes: RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
        )
      end
      @project_response_descriptor
    end

    def project_mapping
      Dispatch.once do
        @project_mapping = RKEntityMapping.mappingForEntityForName('Project', inManagedObjectStore: store)
        @project_mapping.addAttributeMappingsFromArray(['name', 'hash_id'])
        @project_mapping.addAttributeMappingsFromDictionary({'id' => 'semaphore_id'})
        @project_mapping.addPropertyMapping(relationship_mapping)
      end
      @project_mapping
    end

    def relationship_mapping
      Dispatch.once do
        @relationship_mapping = RKRelationshipMapping.relationshipMappingFromKeyPath(
          "branches",
          toKeyPath: "branches",
          withMapping: branch_mapping
        )
      end
      @relationship_mapping
    end

    def branch_mapping
      Dispatch.once do
        @branch_mapping = RKEntityMapping.mappingForEntityForName('Branch', inManagedObjectStore: store)
        @branch_mapping.addAttributeMappingsFromDictionary({'branch_name' => 'name',
          'result' => 'result', 'started_at' => 'started_at', 'finished_at' => 'finished_at',
          'building_date' => 'finished_at'
        })
      end
      @branch_mapping
    end
  end
end
