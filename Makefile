
BRANCH?=$(shell git rev-parse --abbrev-ref HEAD)

all: test clean

test: test_deps vagrant_up

integration_test: clean integration_test_deps vagrant_up clean

test_deps:
	rm -rf tests/vagrant/sansible.*
	ln -s ../.. tests/vagrant/sansible.zookeeper

integration_test_deps:
	sed -i.bak \
		-E 's/(.*)version: (.*)/\1version: origin\/$(BRANCH)/' \
		tests/vagrant/integration_requirements.yml
	rm -rf tests/vagrant/sansible.*
	ansible-galaxy install -p tests/vagrant -r tests/vagrant/integration_requirements.yml
	mv tests/vagrant/integration_requirements.yml.bak tests/vagrant/integration_requirements.yml

vagrant_up:
	@cd tests/vagrant; \
	if (vagrant status | grep -E "(running|saved|poweroff)" 1>/dev/null) then \
		vagrant up || exit 1; \
		vagrant provision || exit 1; \
	else \
		vagrant up || exit 1; \
	fi;

vagrant_ssh:
	@cd tests/vagrant; \
	vagrant up || exit 1; \
	vagrant ssh

clean:
	rm -rf tests/vagrant/sansible.*
	cd tests/vagrant && vagrant destroy
