module IPAddresses
  class FindByDomain
    def self.call(domain)
      Resolv.getaddress domain
    end
  end
end
